import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/attendance.dart';
import 'package:gmsflutter/service/admin_service/attendance_service.dart';
import 'package:intl/intl.dart';

class ViewAttendance extends StatefulWidget {
  const ViewAttendance({Key? key}) : super(key: key);

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {

  late Future<List<Attendance>> attendanceList;
  DateTime? _selectedDate;
  List<Attendance>? _filteredAttendance;

  @override
  void initState() {
    super.initState();
    attendanceList = AttendanceService().fetchAllAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Attendance List')),
      body: FutureBuilder<List<Attendance>>(
        future: attendanceList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('No Attendance Available'));
          } else {
            final attendance = snapshot.data!;
            final displayedAttendance =
            _selectedDate == null ? attendance : _filteredAttendance ?? [];

            return Column(
              children: [
                // Date Filter Section
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'Showing all attendance'
                            : 'Filtered: ${DateFormat('dd-MMM-yyyy').format(_selectedDate!)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  _selectedDate = pickedDate;
                                  _filteredAttendance = attendance.where((att) {
                                    return _isSameDate(
                                        att.attDate, pickedDate);
                                  }).toList();
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today, size: 16),
                            label: const Text('Pick Date'),
                          ),
                          const SizedBox(width: 8),
                          if (_selectedDate != null)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedDate = null;
                                  _filteredAttendance = null;
                                });
                              },
                              icon: const Icon(Icons.clear),
                              tooltip: 'Clear Filter',
                            ),
                        ],
                      )
                    ],
                  ),
                ),

                // Attendance List Section
                Expanded(
                  child: displayedAttendance.isEmpty
                      ? const Center(child: Text('No attendance found for selected date'))
                      : ListView.builder(
                    itemCount: displayedAttendance.length,
                    itemBuilder: (context, index) {
                      final atten = displayedAttendance[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            "Employee ID: ${atten.employee?.id}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Employee Name: ${atten.employee?.name}"),
                              Text("Attendance Date & Time: ${_formatLocalDateTime(atten.attDate)}"),
                              Text("Status: ${atten.status}"),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  /// Converts UTC date string to local formatted date with time.
  String _formatLocalDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return "N/A";
    }

    try {
      final utcDate = DateTime.parse(dateStr);
      final localDate = utcDate.toLocal();
      return DateFormat('dd-MMM-yyyy hh:mm a').format(localDate);
    } catch (e) {
      return "Invalid date";
    }
  }

  /// Checks if two dates are on the same calendar day
  bool _isSameDate(String? dateStr, DateTime selectedDate) {
    if (dateStr == null || dateStr.isEmpty) return false;
    try {
      final parsedDate = DateTime.parse(dateStr).toLocal();
      return parsedDate.year == selectedDate.year &&
          parsedDate.month == selectedDate.month &&
          parsedDate.day == selectedDate.day;
    } catch (e) {
      return false;
    }
  }
}
