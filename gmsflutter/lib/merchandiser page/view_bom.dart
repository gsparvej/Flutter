import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/bom.dart';

// --- Color and Style Palette ---
class BomDetailPalette {
  static const Color primary = Color(0xFF673AB7); // Deep Purple
  static const Color secondary = Color(0xFF00BFA5); // Teal - For metrics
  static const Color accent = Color(0xFFFF9800); // Orange - For key identifier
  static const Color totalCost = Color(0xFFE53935); // Red - For highlighting total cost
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryText = Color(0xFF263238);
  // FIX: Added the missing secondaryText color constant
  static const Color secondaryText = Color(0xFF757575);
}

class ViewBomsByStyleCode extends StatelessWidget {
  final String styleCode;
  final List<BOM> allBoms;

  const ViewBomsByStyleCode({Key? key, required this.styleCode, required this.allBoms}) : super(key: key);

  // Helper function to safely display values, applying formatting for numbers
  String displayValue(dynamic value) {
    if (value == null) return 'N/A';
    if (value is String && value.trim().isEmpty) return 'N/A';
    if (value is double) return value.toStringAsFixed(2); // Format doubles to 2 decimal places
    return value.toString();
  }

  // Helper to build a gorgeous, color-coded detail row
  Widget _buildDetailRow(String label, dynamic value, {Color? valueColor, FontWeight fontWeight = FontWeight.normal}) {
    final display = displayValue(value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                // Using the newly defined secondaryText
                color: BomDetailPalette.secondaryText,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              display,
              style: TextStyle(
                fontWeight: fontWeight,
                color: valueColor ?? BomDetailPalette.primaryText,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildBomCard(BuildContext context, BOM bom) {
    final material = displayValue(bom.material);
    final totalCost = displayValue(bom.totalCost);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 8, // Fabulous elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: BomDetailPalette.secondary.withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Material Name (Fabulous)
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Material: $material",
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: BomDetailPalette.primary,
                ),
              ),
            ),

            const Divider(height: 1, thickness: 1.5, color: BomDetailPalette.secondary),
            const SizedBox(height: 12),

            // Smart Grid Layout for Key Metrics
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 5,
              crossAxisSpacing: 15,
              children: [
                _buildDetailRow("Serial", bom.serial, fontWeight: FontWeight.bold),
                _buildDetailRow("Unit", bom.unit),
                _buildDetailRow("Quantity", bom.quantity, valueColor: BomDetailPalette.secondary),
                _buildDetailRow("Unit Price", bom.unitPrice, valueColor: BomDetailPalette.secondary),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(height: 1, thickness: 0.5),
            const SizedBox(height: 12),

            // Total Cost (Gorgeous Highlight)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: BomDetailPalette.totalCost.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "TOTAL COST",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: BomDetailPalette.totalCost,
                    ),
                  ),
                  Text(
                    totalCost,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: BomDetailPalette.totalCost,
                    ),
                  ),
                ],
              ),
            ),

            // UOM Information (Secondary Detail)
            const SizedBox(height: 12),
            _buildDetailRow("UOM Base Fabric", bom.uom?.baseFabric, valueColor: BomDetailPalette.secondaryText),
          ],
        ),
      ),
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    // Filter the list based on styleCode outside the build method for better efficiency
    final filteredBoms = allBoms.where((bom) => bom.bomStyle?.styleCode == styleCode).toList();

    return Scaffold(
      backgroundColor: BomDetailPalette.background,
      appBar: AppBar(
        title: Text(
          'BOM Details for Style: $styleCode',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        backgroundColor: BomDetailPalette.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: filteredBoms.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.layers_clear, color: BomDetailPalette.secondaryText, size: 50),
            SizedBox(height: 10),
            Text(
              "No Bill of Materials found for this style code.",
              style: TextStyle(fontSize: 16, color: BomDetailPalette.secondaryText),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: filteredBoms.length,
        itemBuilder: (context, index) {
          return _buildBomCard(context, filteredBoms[index]);
        },
      ),
    );
  }
}