import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/employee.dart';
import 'package:gmsflutter/service/admin_service/employee_service.dart';
import 'package:intl/intl.dart';

class ViewEmployee extends StatefulWidget {
  const ViewEmployee({Key? key}) : super(key: key);

  @override
  State<ViewEmployee> createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  late Future<List<Employee>> employeeList;

  @override
  void initState() {
    super.initState();
    employeeList = EmployeeService().fetchAllEmployee();
  }
  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('All Employee List')),
      body: FutureBuilder<List<Employee>>(
        future: employeeList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('No Employee Available'));
          } else {
            final employee = snapshot.data!;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Viewed on: $formattedDate",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: employee.length,
                    itemBuilder: (context, index) {
                      final emp = employee[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            "Employee Name: ${emp.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email: ${emp.email}"),
                              Text("Phone Number: ${emp.phoneNumber}"),
                              Text("Joining Date: ${_formatLocalDate(emp.joinDate)}"),
                              Text("Designation Title: ${emp.designation?.designationTitle}"),
                              Text("Department Name: ${emp.department?.name}")
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

  String _formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return "N/A";
    }

    try {
      final utcDate = DateTime.parse(dateStr);
      final localDate = utcDate.toLocal();
      return DateFormat('dd-MMM-yyyy').format(localDate);
    } catch (e) {
      return "Invalid date";
    }
  }



}
