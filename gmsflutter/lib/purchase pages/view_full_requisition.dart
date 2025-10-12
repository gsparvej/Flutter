import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/full_requisition.dart';
import 'package:intl/intl.dart';

class ViewFullRequisition extends StatelessWidget {
  final FullRequisition requisition;

  const ViewFullRequisition({Key? key, required this.requisition}) : super(key: key);

  String displayValue(dynamic value) {
    if (value == null) return 'N/A';
    if (value is String && value.trim().isEmpty) return 'N/A';
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requisition Details'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Center(
                  child: Text(
                    formatLocalDate(requisition.prDate),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),

                ),
                const SizedBox(height: 20),

                buildRow("Requested By", displayValue(requisition.requestedBy)),
                buildRow("Department", displayValue(requisition.department?.name)),
                buildRow("Item Name", displayValue(requisition.item?.categoryName)),
                buildRow("Quantity", displayValue(requisition.quantity)),
                buildRow("Approx. Unit Price", displayValue(requisition.approxUnitPrice)),
                buildRow("Approx. Total Price", displayValue(requisition.totalEstPrice)),
                buildRow("Order ID", displayValue(requisition.order?.id)),
                buildRow("Status", displayValue(requisition.prStatus)),
                buildRow("Category", displayValue(requisition.item?.categoryName)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value),
          ),
        ],
      ),
    );
  }
  String formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.trim().isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr);
      final formatter = DateFormat.yMMMMd('en_US'); // e.g. October 12, 2025
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

}
