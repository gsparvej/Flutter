import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/vendor.dart';

class VendorDetailsPage extends StatelessWidget {
  final Vendor vendor;

  const VendorDetailsPage({Key? key, required this.vendor}) : super(key: key);

  String displayValue(String? value) {
    if (value == null) return 'N/A';
    if (value.trim().isEmpty) return 'N/A';
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Details'),
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
                    displayValue(vendor.companyName),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const Divider(height: 30, thickness: 1.5, color: Colors.grey),

                // Details Rows
                buildRow("Vendor Name", displayValue(vendor.companyName)),
                buildRow("Contact Person", displayValue(vendor.contactPerson)),
                buildRow("Email", displayValue(vendor.email)),
                buildRow("Phone", displayValue(vendor.phone)),
                buildRow("Address", displayValue(vendor.address)),

                const SizedBox(height: 20),
                const Text(
                  "Registration Numbers:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Divider(height: 10, thickness: 0.5),

                buildRow("TIN", displayValue(vendor.tin)),
                buildRow("BIN", displayValue(vendor.bin)),
                buildRow("VAT", displayValue(vendor.vat)),
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
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
