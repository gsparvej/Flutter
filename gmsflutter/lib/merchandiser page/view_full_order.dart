import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/order.dart';
import 'package:intl/intl.dart';

class ViewFullOrder extends StatelessWidget {
  final Order order;

  const ViewFullOrder({Key? key, required this.order}) : super(key: key);

  String displayValue(dynamic value) {
    if (value == null) return 'N/A';
    if (value is String && value.trim().isEmpty) return 'N/A';
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Center(
                  child: Text(
                    displayValue(order.buyer?.name),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                buildRow("Order Date", formatLocalDate(order.orderDate)),
                buildRow("Delivery Date", formatLocalDate(order.deliveryDate)),
                buildRow("Style Code", displayValue(order.bomStyle?.styleCode)),
                buildRow("Order Status", displayValue(order.orderStatus)),
                buildRow("Remarks", displayValue(order.remarks)),

                const SizedBox(height: 12),
                const Text(
                  "Short Sleeve Sizes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                buildSizePriceRow("S", order.shortSmallSize, order.shortSPrice),
                buildSizePriceRow("M", order.shortMediumSize, order.shortMPrice),
                buildSizePriceRow("L", order.shortLargeSize, order.shortLPrice),
                buildSizePriceRow("XL", order.shortXLSize, order.shortXLPrice),

                const SizedBox(height: 12),
                const Text(
                  "Full Sleeve Sizes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                buildSizePriceRow("S", order.fullSmallSize, order.fullSPrice),
                buildSizePriceRow("M", order.fullMediumSize, order.fullMPrice),
                buildSizePriceRow("L", order.fullLargeSize, order.fullLPrice),
                buildSizePriceRow("XL", order.fullXLSize, order.fullXLPrice),

                const SizedBox(height: 20),
                const Text(
                  "Financial Summary",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                buildRow("Sub Total", displayValue(order.subTotal)),
                buildRow("VAT", displayValue(order.vat)),
                buildRow("Paid Amount", displayValue(order.paidAmount)),
                buildRow("Due Amount", displayValue(order.dueAmount)),
                buildRow("Total", displayValue(order.total)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }

  Widget buildSizePriceRow(String sizeLabel, dynamic size, dynamic price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$sizeLabel Size: ${displayValue(size)}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "$sizeLabel Price: ${displayValue(price)}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  String formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.trim().isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr).toLocal();
      final formatter = DateFormat('dd-MMM-yyyy'); // e.g., 15-Oct-2025
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }
}
