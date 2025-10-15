import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/leave.dart';
import 'package:gmsflutter/service/admin_service/leave_service.dart';
import 'package:intl/intl.dart';

class ViewLeave extends StatefulWidget {
  const ViewLeave({Key? key}) : super(key: key);

  @override
  State<ViewLeave> createState() => _ViewLeaveState();
}

class _ViewLeaveState extends State<ViewLeave> {
  late Future<List<Leave>> leaveList;

  @override
  void initState() {
    super.initState();
    leaveList = LeaveService().fetchAllLeaves();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Leaves')),
      body: FutureBuilder<List<Leave>>(
        future: leaveList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load leaves: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No leaves available'));
          } else {
            final leaves = snapshot.data!;
            return ListView.builder(
              itemCount: leaves.length,
              itemBuilder: (context, index) {
                final leave = leaves[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      "Employee: ${leave.employee?.name ?? 'Unknown'} (ID: ${leave.employee?.id ?? 'N/A'})",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Leave Type: ${leave.leaveType ?? 'N/A'}"),
                        Text("From: ${_formatLocalDate(leave.fromDate)}"),
                        Text("To: ${_formatLocalDate(leave.toDate)}"),
                        Text("Status: ${leave.status ?? 'N/A'}"),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String _formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "N/A";

    try {
      final utcDate = DateTime.parse(dateStr);
      final localDate = utcDate.toLocal();
      return DateFormat('dd-MMM-yyyy').format(localDate);
    } catch (e) {
      return "Invalid date";
    }
  }
}
