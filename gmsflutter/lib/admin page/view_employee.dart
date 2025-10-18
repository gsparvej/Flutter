import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/employee.dart';
import 'package:gmsflutter/service/admin_service/employee_service.dart';
import 'package:intl/intl.dart';

// Helper class for consistent styling
class ColorPalette {
  static const List<Color> accentColors = [
    Color(0xFF4DB6AC), // Teal
    Color(0xFF7986CB), // Indigo
    Color(0xFF81C784), // Light Green
    Color(0xFFFFB74D), // Amber
  ];

  static Color getColor(int index) {
    return accentColors[index % accentColors.length];
  }

  static const Color primaryText = Color(0xFF263238); // Dark Slate
  static const Color secondaryText = Color(0xFF78909C); // Light Gray-Blue
  static const Color appBarColor = Color(0xFF37474F); // Dark Charcoal
}

class ViewEmployee extends StatefulWidget {
  const ViewEmployee({Key? key}) : super(key: key);

  @override
  State<ViewEmployee> createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  late Future<List<Employee>> _employeeFuture;

  @override
  void initState() {
    super.initState();
    _employeeFuture = EmployeeService().fetchAllEmployee();
  }

  // --- Helper Methods ---

  String _formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return "N/A";
    }

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

  Widget _buildEmployeeCard(BuildContext context, Employee employee, int index) {
    final accentColor = ColorPalette.getColor(index);
    final initials = (employee.name?.isNotEmpty == true)
        ? employee.name!.split(' ').map((n) => n[0]).join().toUpperCase()
        : '??';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6, // High elevation for fabulous look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation to employee details/profile
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Viewing ${employee.name}\'s profile')),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar/Initial Circle (Colorful & Fabulous)
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withOpacity(0.8),
                ),
                alignment: Alignment.center,
                child: Text(
                  initials.length > 2 ? initials.substring(0, 2) : initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Employee Details (Smart Typography)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Employee Name (Primary focus)
                    Text(
                      employee.name ?? 'Unnamed Employee',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 19,
                        color: ColorPalette.primaryText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Designation & Department (Grouped and styled)
                    Text(
                      '${employee.designation?.designationTitle ?? 'N/A'} - ${employee.department?.name ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Contact Info (RichText for better data distinction)
                    _buildDetailRow(
                        Icons.email_outlined, employee.email ?? 'N/A',
                        context: context),
                    _buildDetailRow(
                        Icons.phone_outlined, employee.phoneNumber ?? 'N/A',
                        context: context),
                    _buildDetailRow(
                        Icons.calendar_today_outlined,
                        'Joined: ${_formatLocalDate(employee.joinDate)}',
                        context: context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, {required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: ColorPalette.secondaryText),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: ColorPalette.secondaryText,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
    DateFormat('EEEE, dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Active Employee Directory',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: ColorPalette.appBarColor,
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Employee>>(
        future: _employeeFuture,
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
                    const Icon(Icons.sentiment_dissatisfied, color: Colors.redAccent, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      'Failed to load employee data: ${snapshot.error.toString().split(':')[0]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[700], fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }

          final employees = snapshot.data!;

          if (employees.isEmpty) {
            // SMART Empty State
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_alt, color: ColorPalette.secondaryText, size: 50),
                  SizedBox(height: 10),
                  Text('No Employee Records Found.', style: TextStyle(fontSize: 18, color: ColorPalette.secondaryText)),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Date Header (SMART)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Directory last updated: $formattedDate",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                      color: ColorPalette.secondaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // Employee Count Badge (FABULOUS/SMART)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Total Active Employees: ${employees.length}',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 4),

              // Employee List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 4),
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    return _buildEmployeeCard(context, employees[index], index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}