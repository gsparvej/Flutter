import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/raw_materials_check.dart';
import 'package:gmsflutter/service/merchandiser_service/raw_materials_check_service.dart';

// --- Color and Style Palette (Forest Green & Gold) ---
class RawMaterialPalette {
  static const Color primary = Color(0xFF1B5E20); // Deep Forest Green - Trustworthy
  static const Color accent = Color(0xFFFFC107); // Gold/Amber - Highlight
  // FIX: Defined secondary as a valid Color constant (Deep Bronze)
  static const Color secondary = Color(0xFF795548);
  static const Color background = Color(0xFFE8F5E9); // Light Green Background
  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);
  static const Color totalMetric = Color(0xFFD84315); // Deep Orange - Total Importance
}

class ViewRawMaterialsCheck extends StatefulWidget {
  const ViewRawMaterialsCheck({Key? key}) : super(key: key);

  @override
  State<ViewRawMaterialsCheck> createState() => _ViewRawMaterialsCheckState();
}

class _ViewRawMaterialsCheckState extends State<ViewRawMaterialsCheck> {
  late Future<List<RawMaterialsCheck>> _rawMaterialsCheckListFuture;

  @override
  void initState() {
    super.initState();
    _rawMaterialsCheckListFuture = RawMaterialsCheckService().fetchRawMaterials();
  }

  // Helper method to safely display quantity
  String displayQty(int? qty) {
    return qty?.toString() ?? 'N/A';
  }

  // Fabulous Size/Quantity Row Builder
  Widget _buildSizeRow(String size, int? qty) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // FIX: RawMaterialPalette.secondary is now a valid Color
          Icon(Icons.crop_square, size: 16, color: RawMaterialPalette.secondary.withOpacity(0.8)),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              "$size Size Required:",
              style: const TextStyle(
                fontSize: 14,
                color: RawMaterialPalette.primaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              displayQty(qty),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: RawMaterialPalette.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildMaterialCheckCard(BuildContext context, RawMaterialsCheck materials) {
    final rawId = materials.id?.toString() ?? 'N/A';
    final orderId = materials.order?.id?.toString() ?? 'N/A';
    final totalFabric = materials.totalFabric?.toStringAsFixed(2) ?? 'N/A';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 8, // Fabulous elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation to a detailed view if necessary
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Viewing Raw Materials Check for Order #$orderId')),
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Order ID (Colorful & Gorgeous)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.inventory_2, color: RawMaterialPalette.primary, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    "Order ID: #$orderId",
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: RawMaterialPalette.primary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Check ID: $rawId",
                    style: const TextStyle(
                      fontSize: 14,
                      color: RawMaterialPalette.secondaryText,
                    ),
                  ),
                ],
              ),

              const Divider(height: 25, thickness: 1.5, color: RawMaterialPalette.accent),

              // --- Quantity Section ---
              const Text(
                "Required Quantity Breakdown:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: RawMaterialPalette.primaryText,
                ),
              ),
              const SizedBox(height: 10),

              // Smart Grid Layout for Sizes
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3.5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Short Sleeve
                  _buildSizeRow("Short S", materials.shortSTotalQuantity),
                  _buildSizeRow("Short M", materials.shortMTotalQuantity),
                  _buildSizeRow("Short L", materials.shortLTotalQuantity),
                  _buildSizeRow("Short XL", materials.shortXLTotalQuantity),

                  // Full Sleeve
                  _buildSizeRow("Full S", materials.fullSTotalQuantity),
                  _buildSizeRow("Full M", materials.fullMTotalQuantity),
                  _buildSizeRow("Full L", materials.fullLTotalQuantity),
                  _buildSizeRow("Full XL", materials.fullXLTotalQuantity),
                ],
              ),

              const SizedBox(height: 15),
              const Divider(height: 1, thickness: 1, color: RawMaterialPalette.secondaryText),
              const SizedBox(height: 15),

              // --- Total Fabric Needed (Smart & Fabulous Highlight) ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: RawMaterialPalette.totalMetric.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: RawMaterialPalette.totalMetric.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "TOTAL FABRIC NEEDED:",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: RawMaterialPalette.totalMetric,
                      ),
                    ),
                    Text(
                      "$totalFabric units",
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: RawMaterialPalette.totalMetric,
                      ),
                    ),
                  ],
                ),
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
      backgroundColor: RawMaterialPalette.background,
      appBar: AppBar(
        title: const Text(
          'Raw Materials Check Register',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: RawMaterialPalette.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<RawMaterialsCheck>>(
        future: _rawMaterialsCheckListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: RawMaterialPalette.primary),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.report_problem, color: RawMaterialPalette.totalMetric, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      "Error fetching materials data: ${snapshot.error}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: RawMaterialPalette.totalMetric, fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.no_sim, color: RawMaterialPalette.secondaryText, size: 50),
                  SizedBox(height: 10),
                  Text('No Raw Materials Check records found.', style: TextStyle(fontSize: 18, color: RawMaterialPalette.secondaryText)),
                ],
              ),
            );
          } else {
            final rawList = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: rawList.length,
              itemBuilder: (context, index) {
                return _buildMaterialCheckCard(context, rawList[index]);
              },
            );
          }
        },
      ),
    );
  }
}