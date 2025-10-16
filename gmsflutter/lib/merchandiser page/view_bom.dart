import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/bom.dart';

class ViewBomsByStyleCode extends StatelessWidget {
  final String styleCode;
  final List<BOM> allBoms;

  const ViewBomsByStyleCode({Key? key, required this.styleCode, required this.allBoms}) : super(key: key);

  String displayValue(dynamic value) {
    if (value == null) return 'N/A';
    if (value is String && value.trim().isEmpty) return 'N/A';
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBoms = allBoms.where((bom) => bom.bomStyle?.styleCode == styleCode).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('BOMs for Style: $styleCode'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: filteredBoms.isEmpty
          ? const Center(child: Text("No BOMs found for this style."))
          : ListView.builder(
        itemCount: filteredBoms.length,
        itemBuilder: (context, index) {
          final bom = filteredBoms[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Material: ${displayValue(bom.material)}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  buildRow("Serial", displayValue(bom.serial)),
                  buildRow("Unit", displayValue(bom.unit)),
                  buildRow("Quantity", displayValue(bom.quantity)),
                  buildRow("Unit Price", displayValue(bom.unitPrice)),
                  buildRow("Total Cost", displayValue(bom.totalCost)),
                  buildRow("UOM", displayValue(bom.uom?.baseFabric)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text("$label:", style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
}
