import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/attendance.dart';
import 'package:gmsflutter/service/admin_service/attendance_service.dart';
import 'package:intl/intl.dart';

// Helper class for consistent styling and color-coding
class ColorPalette {
  // Define colors based on attendance status
  static Color getStatusColor(String? status) {
    if (status == null) return Colors.grey;
    final lowerStatus = status.toLowerCase();
    switch (lowerStatus) {
      case 'present':
        return Colors.green[600]!;
      case 'absent':
        return Colors.red[600]!;
      case 'on leave':
        return Colors.blue[600]!;
      default:
        return Colors.amber[600]!;
    }
  }

  static const Color appBarColor = Color(0xFF5E35B1); // Deep Purple
  static const Color primaryText = Color(0xFF263238);
  static const Color secondaryText = Color(0xFF757575);
}

class ViewAttendance extends StatefulWidget {
  const ViewAttendance({Key? key}) : super(key: key);

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  late Future<List<Attendance>> _attendanceFuture;
  DateTime? _selectedDate;
  List<Attendance>? _allAttendance;
  List<Attendance>? _filteredAttendance;

  @override
  void initState() {
    super.initState();
    _attendanceFuture = AttendanceService().fetchAllAttendance();
  }

  // Helper method to show Date Picker and update filter
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        // Ensure _allAttendance is available before filtering
        if (_allAttendance != null) {
          _filteredAttendance = _allAttendance!.where((att) {
            return _isSameDate(att.attDate, pickedDate);
          }).toList();
        }
      });
    }
  }

  // Clears the filter and resets the displayed list
  void _clearFilter() {
    setState(() {
      _selectedDate = null;
      _filteredAttendance = _allAttendance; // Display all when filter is clear
    });
  }

  // --- Widget Builders ---

  Widget _buildAttendanceCard(Attendance atten) {
    final statusColor = ColorPalette.getStatusColor(atten.status);
    final employeeName = atten.employee?.name ?? 'Unknown Employee';
    final employeeId = atten.employee?.id ?? 'N/A';
    // Use the updated method to show both date and time
    final formattedDateTime = _formatLocalDateTime(atten.attDate);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6, // Fabulous elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Status Indicator Circle (Smart & Colorful)
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(top: 4.0),
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Employee Name (Primary Focus)
                  Text(
                    employeeName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: ColorPalette.primaryText,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Employee ID
                  Text(
                    'ID: $employeeId',
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorPalette.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Attendance Date & Time (Smart icon prefix)
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 16, color: ColorPalette.secondaryText),
                      const SizedBox(width: 5),
                      Text(
                        // Displaying both date and time
                        'Time: $formattedDateTime',
                        style: const TextStyle(fontSize: 14, color: ColorPalette.secondaryText),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Status Badge (Fabulous & Colorful)
            _buildStatusBadge(atten.status, statusColor),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String? status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status?.toUpperCase() ?? 'N/A',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, int totalCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedDate == null
                      ? 'Showing All Records ($totalCount)'
                      : DateFormat('EEEE, dd MMM yyyy').format(_selectedDate!),
                  style: TextStyle(
                    fontSize: _selectedDate == null ? 14 : 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedDate == null ? ColorPalette.secondaryText : ColorPalette.primaryText,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (_selectedDate != null)
                  Text(
                    'Total for this day: $totalCount',
                    style: const TextStyle(fontSize: 13, color: ColorPalette.secondaryText),
                  ),
              ],
            ),
          ),

          Row(
            children: [
              // Stylish 'Pick Date' button (FABULOUS)
              ActionChip(
                label: Text(
                  _selectedDate == null ? 'Select Date' : 'Change Date',
                  style: TextStyle(
                      color: ColorPalette.appBarColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
                avatar: Icon(Icons.calendar_today, size: 16, color: ColorPalette.appBarColor),
                onPressed: _pickDate,
                backgroundColor: ColorPalette.appBarColor.withOpacity(0.1),
              ),
              if (_selectedDate != null)
              // Clear filter button (SMART UX)
                IconButton(
                  onPressed: _clearFilter,
                  icon: const Icon(Icons.close, size: 24, color: Colors.grey),
                  tooltip: 'Clear Date Filter',
                ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Attendance Log',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: ColorPalette.appBarColor, // Colorful AppBar
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Attendance>>(
        future: _attendanceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: ColorPalette.appBarColor));
          }

          if (snapshot.hasError) {
            // FABULOUS Error State
            return Center(
              child: Text(
                'Attendance data unavailable.',
                style: TextStyle(color: Colors.red[700], fontSize: 18),
              ),
            );
          }

          _allAttendance = snapshot.data!;
          // Initialize or update filtered list
          if (_filteredAttendance == null || _selectedDate == null) {
            _filteredAttendance = _allAttendance;
          }
          final displayedAttendance = _filteredAttendance ?? [];

          return Column(
            children: [
              // Date Filter Bar (Smart & Fabulous)
              _buildFilterBar(context, displayedAttendance.length),

              // Attendance List Section
              Expanded(
                child: displayedAttendance.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                  padding: const EdgeInsets.only(top: 8),
                  itemCount: displayedAttendance.length,
                  itemBuilder: (context, index) {
                    return _buildAttendanceCard(displayedAttendance[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 50, color: Colors.grey[400]),
          const SizedBox(height: 10),
          Text(
            _selectedDate == null
                ? 'No attendance records found at all.'
                : 'No attendance recorded for ${DateFormat('dd MMM yyyy').format(_selectedDate!)}.',
            style: const TextStyle(fontSize: 16, color: ColorPalette.secondaryText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Converts UTC date string to local formatted date with time.
  String _formatLocalDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return "N/A";
    }

    try {
      final utcDate = DateTime.parse(dateStr).toUtc();
      final localDate = utcDate.toLocal();
      // FIX APPLIED: Includes day, date, month, and time
      return DateFormat('EEE, dd MMM hh:mm a').format(localDate);
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