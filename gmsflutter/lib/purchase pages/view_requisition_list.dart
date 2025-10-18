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
    // Initialize the future to fetch data on load
    requisitionList = RequisitionService().fetchRequisitions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Requisition List'),
        backgroundColor: Colors.deepPurple, // Added color for AppBar consistency
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<RequisitionList>>(
        future: requisitionList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
          } else if (snapshot.hasError) {
            // Display a more friendly error message
            return Center(child: Text('Failed to load requisitions. Error: ${snapshot.error}', textAlign: TextAlign.center, style: TextStyle(color: Colors.red)));
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
                  elevation: 4, // Added elevation for a nicer look
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      // Emphasizing the date as the primary identifier on the list
                      "Requisition Date: ${formatLocalDate(requi.prDate)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        // Using RichText to highlight the label
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14, height: 1.5),
                            children: <TextSpan>[
                              const TextSpan(text: "Status: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                              TextSpan(text: display(requi.prStatus), style: TextStyle(color: (requi.prStatus == 'Pending' ? Colors.orange : Colors.green.shade800), fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Requested By
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14, height: 1.5),
                            children: <TextSpan>[
                              const TextSpan(text: "Requested By: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                              TextSpan(text: display(requi.requestedBy), style: const TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                // Safely checking for null ID before proceeding
                                if (requi.id == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Requisition ID is missing.")),
                                  );
                                  return;
                                }

                                print("Fetching requisition by ID: ${requi.id}");

                                // Added a temporary loading indicator/state to improve UX during fetch
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Row(
                                      children: [
                                        CircularProgressIndicator(color: Colors.white),
                                        SizedBox(width: 16),
                                        Text("Loading details..."),
                                      ],
                                    ),
                                    duration: Duration(seconds: 1),
                                  ),
                                );

                                FullRequisition fullRequisition =
                                await RequisitionService().getRequisitionById(requi.id!);
                                print("Received JSON: ${jsonEncode(fullRequisition.toJson())}");

                                // Clear the loading snackbar before navigating
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ViewFullRequisition(requisition: fullRequisition),
                                  ),
                                );
                              } catch (e) {
                                print("Error fetching full requisition: $e");
                                // Ensure error message is displayed
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Failed to load requisition details: $e")),
                                );
                              }
                            },
                            icon: const Icon(Icons.receipt_long),
                            label: const Text('View Full Details'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              elevation: 4,
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

  // --- Utility Functions ---

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
