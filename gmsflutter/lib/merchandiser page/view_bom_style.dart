import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/bom_style.dart';
import 'package:gmsflutter/merchandiser%20page/view_bom.dart';
import 'package:gmsflutter/service/merchandiser_service/bom_style_service.dart';

// --- Color and Style Palette ---
class BomPalette {
  static const Color primary = Color(0xFF673AB7); // Deep Purple - Authority
  static const Color accent = Color(0xFFFFC107); // Amber - Key Action Highlight
  static const Color cardBackground = Colors.white;
  static const Color primaryText = Color(0xFF263238);
  static const Color secondaryText = Color(0xFF757575);
  static const Color actionButton = Color(0xFF00BFA5); // Teal - Go/View
}

class ViewBomStyle extends StatefulWidget {
  const ViewBomStyle({Key? key}) : super(key: key);

  @override
  State<ViewBomStyle> createState() => _ViewBomStyleState();
}

class _ViewBomStyleState extends State<ViewBomStyle> {
  late Future<List<BomStyle>> _bomStyleListFuture;

  @override
  void initState() {
    super.initState();
    _bomStyleListFuture = BomStyleService().fetchAllBomStyles();
  }

  // Helper for consistent detail rows
  Widget _buildDetailRow({required String label, required String value, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 6.0, top: 2.0),
              child: Icon(icon, size: 16, color: BomPalette.secondaryText),
            ),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              color: BomPalette.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: BomPalette.primaryText,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Smart Navigation Handler
  void _viewBoms(BuildContext context, String styleCode) async {
    try {
      final fetchedBoms = await BomStyleService().getBOMByStyleCode(styleCode);

      if (!mounted) return; // Safety check

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewBomsByStyleCode(
            styleCode: styleCode,
            allBoms: fetchedBoms,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load BOM details: ${e.toString()}'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // --- Widget Builders ---

  Widget _buildBomStyleCard(BuildContext context, BomStyle bom) {
    final styleCode = bom.styleCode ?? 'UNKNOWN';
    final styleType = bom.styleType ?? 'N/A';
    final description = bom.description ?? 'No description provided.';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 10, // Fabulous elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        // Gorgeous, subtle border
        side: BorderSide(color: BomPalette.primary.withOpacity(0.2), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Style Code (Colorful & Bold)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.palette_outlined, color: BomPalette.primary, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    styleCode,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      color: BomPalette.primary,
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Type Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: BomPalette.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    styleType,
                    style: TextStyle(
                      color: BomPalette.accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 18, thickness: 1),

            // Details Section
            _buildDetailRow(label: 'Style Type', value: styleType, icon: Icons.category),
            _buildDetailRow(label: 'Description', value: description, icon: Icons.notes),

            const SizedBox(height: 15),

            // Action Button (Smart & Prominent)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: styleCode == 'UNKNOWN' ? null : () => _viewBoms(context, styleCode),
                icon: const Icon(Icons.dashboard, size: 20),
                label: const Text(
                  'VIEW BILL OF MATERIALS',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BomPalette.actionButton,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BomPalette.cardBackground.withOpacity(0.95),
      appBar: AppBar(
        title: const Text(
          'BOM Style Register',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: BomPalette.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // TODO: Implement Add BOM Style functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Add BOM Style Form')),
              );
            },
            tooltip: 'Add New BOM Style',
          )
        ],
      ),
      body: FutureBuilder<List<BomStyle>>(
        future: _bomStyleListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: BomPalette.primary),
            );
          } else if (snapshot.hasError) {
            // Fabulous Error State
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_off, color: Colors.redAccent, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      "Failed to load BOM styles. Server unreachable.",
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
                  Icon(Icons.style_outlined, color: BomPalette.secondaryText, size: 50),
                  SizedBox(height: 10),
                  Text('No Bill of Materials Styles found.', style: TextStyle(fontSize: 18, color: BomPalette.secondaryText)),
                ],
              ),
            );
          } else {
            final bomStyles = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: bomStyles.length,
              itemBuilder: (context, index) {
                return _buildBomStyleCard(context, bomStyles[index]);
              },
            );
          }
        },
      ),
    );
  }
}