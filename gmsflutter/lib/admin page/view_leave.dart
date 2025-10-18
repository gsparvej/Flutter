import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/leave.dart';
import 'package:gmsflutter/service/admin_service/leave_service.dart';
import 'package:intl/intl.dart';

// Helper class for consistent styling and color-coding
class ColorPalette {
  // Define colors based on leave status for better visual cues
  static Color getStatusColor(String? status) {
    if (status == null) return Colors.grey[400]!;
    final lowerStatus = status.toLowerCase();
    switch (lowerStatus) {
      case 'approved':
        return Colors.green[600]!;
      case 'pending':
        return Colors.amber[700]!;
      case 'rejected':
        return Colors.red[600]!;
      default:
        return Colors.blueGrey[400]!;
    }
  }

  static const Color appBarColor = Color(0xFF5C6BC0); // Indigo
  static const Color primaryText = Color(0xFF263238);
  static const Color secondaryText = Color(0xFF757575);
}

class ViewLeave extends StatefulWidget {
  const ViewLeave({Key? key}) : super(key: key);

  @override
  State<ViewLeave> createState() => _ViewLeaveState();
}

class _ViewLeaveState extends State<ViewLeave> {
  late Future<List<Leave>> _leaveFuture;

  @override
  void initState() {
    super.initState();
    _leaveFuture = LeaveService().fetchAllLeaves();
  }

  // --- Helper Methods ---

  String _formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "N/A";

    try {
      // Assuming dateStr is UTC/ISO 8601, parse it and convert to local time
      final utcDate = DateTime.parse(dateStr).toUtc();
      final localDate = utcDate.toLocal();
      return DateFormat('dd MMM yyyy').format(localDate);
    } catch (e) {
      return "Invalid date";
    }
  }

  // --- Widget Builders ---

  Widget _buildLeaveCard(BuildContext context, Leave leave) {
    final statusColor = ColorPalette.getStatusColor(leave.status);
    final employeeName = leave.employee?.name ?? 'Unknown Employee';
    final employeeId = leave.employee?.id ?? 'N/A';
    final duration = _formatLocalDate(leave.fromDate) == _formatLocalDate(leave.toDate)
        ? _formatLocalDate(leave.fromDate)
        : '${_formatLocalDate(leave.fromDate)} to ${_formatLocalDate(leave.toDate)}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6, // Fabulous elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        // Color accent border for fabulous touch
        side: BorderSide(color: statusColor.withOpacity(0.3), width: 1.5),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation to review/approve/reject leave
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reviewing leave for $employeeName')),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Colored Status Indicator Bar (Smart & Colorful)
              Container(
                width: 5,
                height: 70, // Height to match content
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Employee Name & ID (Primary Focus)
                    Text(
                      employeeName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: ColorPalette.primaryText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Leave Type and Duration
                    Text(
                      '${leave.leaveType ?? 'N/A'} - $duration',
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorPalette.secondaryText,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Employee ID
                    Text(
                      'Employee ID: $employeeId',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey[400],
                      ),
                    ),
                  ],
                ),
              ),

              // Status Badge (Fabulous & Colorful)
              _buildStatusBadge(leave.status, statusColor),
            ],
          ),
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
          fontSize: 12,
        ),
      ),
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Leave Requests',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: ColorPalette.appBarColor, // Colorful AppBar
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Leave>>(
        future: _leaveFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: ColorPalette.appBarColor));
          }

          if (snapshot.hasError) {
            // FABULOUS Error State
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.mood_bad, color: Colors.redAccent, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      'Could not fetch leave data. Error: ${snapshot.error.toString().split(':')[0]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[700], fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }

          final leaves = snapshot.data!;

          if (leaves.isEmpty) {
            // SMART Empty State
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, color: ColorPalette.secondaryText, size: 50),
                  SizedBox(height: 10),
                  Text('No Leave Requests Found.', style: TextStyle(fontSize: 18, color: ColorPalette.secondaryText)),
                ],
              ),
            );
          }

          // SMART: Use ListView with enhanced cards
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: leaves.length,
            itemBuilder: (context, index) {
              return _buildLeaveCard(context, leaves[index]);
            },
          );
        },
      ),
    );
  }
}