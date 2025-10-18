import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/uom.dart';
import 'package:gmsflutter/service/merchandiser_service/uom_service.dart';

// --- Color and Style Palette ---
class UomPalette {
  static const Color primary = Color(0xFF00BFA5); // Teal Accent - For technical/metric focus
  static const Color accent = Color(0xFFFF9800); // Orange - For key identifiers
  static const Color cardBackground = Colors.white;
  static const Color primaryText = Color(0xFF263238);
  static const Color secondaryText = Color(0xFF757575);
  static const Color metricColor = Color(0xFF4DB6AC); // Lighter Teal for metric values
}

class ViewUom extends StatefulWidget {
  const ViewUom({Key? key}) : super(key: key);

  @override
  State<ViewUom> createState() => _ViewUomState();
}

class _ViewUomState extends State<ViewUom> {
  late Future<List<Uom>> _uomListFuture;

  @override
  void initState() {
    super.initState();
    _uomListFuture = UomService().fetchUom();
  }

  // Helper method to build a detail row (Smart & Clean)
  Widget _buildDetailRow({required String label, String? value, Color? valueColor}) {
    // Smart: Only display the row if the value is available and not null/empty
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 13,
              color: UomPalette.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: valueColor ?? UomPalette.primaryText,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildUomCard(BuildContext context, Uom uom) {
    final size = uom.size ?? 'N/A';
    final productName = uom.productName ?? 'Generic Product';

    // FIX: Safely convert all double? properties to String? for the _buildDetailRow function
    String? doubleToString(double? value) {
      // Safely converts double? to a string, optionally formatting it
      return value?.toStringAsFixed(2);
    }

    // Check if the service returned the data as String or Double by using the correct converter
    // If you are certain they are Doubles, use the doubleToString helper.
    // If you are not certain, you can assume they are Strings (based on the original code's type inference)
    // but the error message confirms at least one is a double?. We'll apply the safe conversion to all numeric-like fields.

    final bodyStr = doubleToString(uom.body);
    final sleeveStr = doubleToString(uom.sleeve);
    final pocketStr = doubleToString(uom.pocket);
    final wastageStr = doubleToString(uom.wastage);
    final shrinkageStr = doubleToString(uom.shrinkage);
    final baseFabricStr = doubleToString(uom.baseFabric);


    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6, // Fabulous elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        // Colorful accent border
        side: BorderSide(color: UomPalette.primary.withOpacity(0.5), width: 2),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation to UOM detail/edit page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Viewing UOM for Size: $size')),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header: Size and Product Name (Fabulous & Clear)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Size: $size',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: UomPalette.primaryText,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: UomPalette.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      productName,
                      style: TextStyle(
                        color: UomPalette.accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 16, thickness: 1),

              // 2. Consumption and Wastage Metrics (Smart Layout in Two Columns)
              Text(
                'Fabric Consumption Details (in units)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: UomPalette.primary.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 8),

              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 4.0, // Control item height
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                children: [
                  // Use the converted String values here
                  _buildDetailRow(label: 'Body Fabric', value: bodyStr, valueColor: UomPalette.metricColor),
                  _buildDetailRow(label: 'Sleeve Fabric', value: sleeveStr, valueColor: UomPalette.metricColor),
                  _buildDetailRow(label: 'Pocket Fabric', value: pocketStr, valueColor: UomPalette.metricColor),
                  _buildDetailRow(label: 'Base Fabric', value: baseFabricStr, valueColor: UomPalette.metricColor),
                  // Highlighted Metrics (Wastage/Shrinkage)
                  _buildDetailRow(label: 'Wastage (%)', value: wastageStr, valueColor: Colors.red[700]),
                  _buildDetailRow(label: 'Shrinkage (%)', value: shrinkageStr, valueColor: Colors.purple),
                ].where((widget) => widget != null).cast<Widget>().toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UomPalette.cardBackground.withOpacity(0.95),
      appBar: AppBar(
        title: const Text(
          'Product UOM Metrics',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: UomPalette.primary, // Colorful AppBar
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // TODO: Implement Add UOM functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Add UOM Form')),
              );
            },
            tooltip: 'Add New UOM',
          )
        ],
      ),
      body: FutureBuilder<List<Uom>>(
        future: _uomListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: UomPalette.primary),
            );
          } else if (snapshot.hasError) {
            // Fabulous Error State
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.redAccent, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      "Failed to load UOM data. Check service connection.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[700], fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Smart Empty State
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.widgets_outlined, color: UomPalette.secondaryText, size: 50),
                  SizedBox(height: 10),
                  Text('No Unit of Measurement records found.', style: TextStyle(fontSize: 18, color: UomPalette.secondaryText)),
                ],
              ),
            );
          } else {
            final uoms = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: uoms.length,
              itemBuilder: (context, index) {
                return _buildUomCard(context, uoms[index]);
              },
            );
          }
        },
      ),
    );
  }
}