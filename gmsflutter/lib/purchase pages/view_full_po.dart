import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/purchase_order.dart';
import 'package:intl/intl.dart';

class ViewFullPO extends StatelessWidget {
  final PurchaseOrder purchase;

  const ViewFullPO({Key? key, required this.purchase}) : super(key: key);

  String displayValue(dynamic value) {
    if (value == null) return 'N/A';
    if (value is String && value.trim().isEmpty) return 'N/A';
    return value.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Order Details'),
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
                    displayValue(purchase.item?.categoryName),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                buildRow("Delivery Date", formatLocalDate(purchase.deliveryDate)),
                buildRow("PO Date", formatLocalDate(purchase.poDate)),
                buildRow("PO Number", displayValue(purchase.poNumber)),
                buildRow("Product Name", displayValue(purchase.item?.categoryName)),
                buildRow("Quantity", displayValue(purchase.quantity)),
                buildRow("Tax(%)", displayValue(purchase.tax)),
                buildRow("Sub Total", displayValue(purchase.subTotal)),
                buildRow("Total", displayValue(purchase.totalAmount)),

                buildRow("Vendor Name", displayValue(purchase.vendor?.companyName)),
                buildRow("Contact Person", displayValue(purchase.vendor?.contactPerson)),
                buildRow("Contact Number", displayValue(purchase.vendor?.phone)),
                buildRow("Vendor Address", displayValue(purchase.vendor?.address)),

                buildRow("Terms & Conditions", displayValue(purchase.termsAndCondition))
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