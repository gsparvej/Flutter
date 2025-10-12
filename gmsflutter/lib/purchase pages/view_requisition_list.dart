import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:gmsflutter/entity/purchase_part/requisition_list_entity.dart';
import 'package:gmsflutter/entity/purchase_part/full_requisition.dart'; // ✅ Import the full requisition model
import 'package:gmsflutter/purchase%20pages/view_full_requisition.dart';
import 'package:gmsflutter/service/purchase_service/requisition_service.dart';

class ViewRequisitionList extends StatefulWidget {
  const ViewRequisitionList({Key? key}) : super(key: key);

  @override
  State<ViewRequisitionList> createState() => _ViewRequisitionListState();
}

class _ViewRequisitionListState extends State<ViewRequisitionList> {
  late Future<List<RequisitionList>> requisitionList;

  @override
  void initState() {
    super.initState();
    requisitionList = RequisitionService().fetchRequisitions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Requisition List')),
      body: FutureBuilder<List<RequisitionList>>(
        future: requisitionList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Requisition List Available'));
          } else {
            final requisitions = snapshot.data!;
            return ListView.builder(
              itemCount: requisitions.length,
              itemBuilder: (context, index) {
                final requi = requisitions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      "Requisition Date: ${formatLocalDate(requi.prDate)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Requisition Status: ${display(requi.prStatus)}"),
                        const SizedBox(height: 4),
                        Text("Requested By: ${display(requi.requestedBy)}"),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  print("Fetching requisition by ID: ${requi.id}");
                                  FullRequisition fullRequisition =
                                  await RequisitionService().getRequisitionById(requi.id!);
                                  print("Received JSON: ${jsonEncode(fullRequisition.toJson())}");

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewFullRequisition(requisition: fullRequisition),
                                    ),
                                  );
                                } catch (e) {
                                  print("Error: $e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Failed to load requisition details")),
                                  );
                                }
                              },

                              child: const Text('View'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.trim().isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr);
      final formatter = DateFormat.yMMMMd('en_US');
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

  String display(String? value) {
    if (value == null || value.trim().isEmpty) return 'N/A';
    return value;
  }
}
