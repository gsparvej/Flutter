import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/designation.dart';
import 'package:gmsflutter/service/admin_service/designation_service.dart';

class ViewDesignation extends StatefulWidget {
  const ViewDesignation({Key? key}) : super(key: key);

  @override
  State<ViewDesignation> createState() => _ViewDesignationState();
}

class _ViewDesignationState extends State<ViewDesignation> {
  late Future<List<Designation>> designationList;

  @override
  void initState() {
    super.initState();
    designationList = DesignationService().fetchAllDesignationt();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Designation List')),
      body: FutureBuilder<List<Designation>>(
        future: designationList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('No Designation Availabe'));
          } else {
            final designation = snapshot.data!;
            return ListView.builder(
              itemCount: designation.length,
              itemBuilder: (context, index) {
                final desig = designation[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      ("Designation Title: ${desig.designationTitle}"),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (desig.department != null)
                          Text("Department Name: ${desig.department?.name}")
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
}
