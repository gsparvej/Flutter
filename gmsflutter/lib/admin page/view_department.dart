import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/department.dart';
import 'package:gmsflutter/service/admin_service/department_service.dart';

class ViewDepartment extends StatefulWidget {
  const ViewDepartment({Key? key}) : super(key: key);

  @override
  State<ViewDepartment> createState() => _ViewDepartmentState();
}

class _ViewDepartmentState extends State<ViewDepartment> {
  late Future<List<Department>> departmentList;

  @override
  void initState() {
    super.initState();
    departmentList = DepartmentService().fetchAllDepartment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Department List')),
      body: FutureBuilder<List<Department>>(
        future: departmentList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('No Department Availabe'));
          } else {
            final department = snapshot.data!;
            return ListView.builder(
              itemCount: department.length,
              itemBuilder: (context, index) {
                final depart = department[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      ("Department Name: ${depart.name}"),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
}
