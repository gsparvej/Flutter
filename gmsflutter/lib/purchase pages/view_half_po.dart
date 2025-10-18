import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/purchase_order.dart';
import 'package:gmsflutter/purchase%20pages/view_full_po.dart';
import 'package:gmsflutter/service/purchase_service/purchase_order_service.dart';
import 'package:intl/intl.dart';

// --- Color and Style Palette (Red & Slate Grey) ---
class POPalette {
  static const Color primary = Color(0xFFD56C6C); // Deep Red - Authority/Urgency
  static const Color accent = Color(0xFF455A64); // Slate Grey - Professional/Detail
  static const Color background = Color(0xFFFBEBEB); // Very Light Red/Grey
  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);
  static const Color deliveryDateUrgent = Color(0xFFAC2D2D); // Darker Red for emphasis
  static const Color actionButton = Color(0xFF00ACC1); // Teal - Distinct Action
}

class ViewHalfPO extends StatefulWidget {
  const ViewHalfPO({Key? key}) : super(key: key);

  @override
  State<ViewHalfPO> createState() => _ViewHalfPOState();
}

class _ViewHalfPOState extends State<ViewHalfPO> {
  late Future<List<PurchaseOrder>> _purchaseOrderListFuture;

  @override
  void initState() {
    super.initState();
    _purchaseOrderListFuture = PurchaseOrderService().fetchPOs();
  }

  // Helper for safe display
  String display(String? value) {
    if (value == null || value.trim().isEmpty) return 'N/A';
    return value;
  }

  // Helper for date formatting and urgency check
  String formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.trim().isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr);
      // Fabulous Date Format: 12 OCT 2025
      final formatter = DateFormat('dd MMM yyyy');
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

  Color _getDeliveryDateColor(String? dateStr) {
    if (dateStr == null) return POPalette.secondaryText;
    try {
      final date = DateTime.parse(dateStr).toLocal();
      // Check if delivery is due within 7 days
      if (date.difference(DateTime.now()).inDays <= 7) {
        return POPalette.deliveryDateUrgent; // Red for urgency
      }
      return POPalette.accent; // Slate for normal
    } catch (_) {
      return POPalette.secondaryText;
    }
  }

  // Smart Navigation Handler
  void _viewFullPO(BuildContext context, int? poId) async {
    if (poId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: PO ID is missing.')),
      );
      return;
    }

    try {
      PurchaseOrder pur = await PurchaseOrderService().getPOsById(poId);
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewFullPO(purchase: pur),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load full PO: ${e.toString()}')),
      );
    }
  }

  // Helper to build a clean detail row
  Widget _buildDetailRow({required String label, required String value, Color? valueColor, FontWeight fontWeight = FontWeight.w500}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              color: POPalette.secondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor ?? POPalette.primaryText,
                fontWeight: fontWeight,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders ---
  Widget _buildPOCard(BuildContext context, PurchaseOrder po) {
    final deliveryDateStr = formatLocalDate(po.deliveryDate);
    final poDateStr = formatLocalDate(po.poDate);
    final deliveryColor = _getDeliveryDateColor(po.deliveryDate);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 8, // Fabulous elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: POPalette.primary.withOpacity(0.2), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: PO Number (Colorful & Gorgeous)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.receipt_long, color: POPalette.primary, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "PO # ${display(po.poNumber)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: POPalette.primary,
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const Divider(height: 18, thickness: 1),

            // Details Section
            _buildDetailRow(
              label: 'Vendor',
              value: display(po.vendor?.companyName),
              fontWeight: FontWeight.bold,
            ),
            _buildDetailRow(
              label: 'PO Date',
              value: poDateStr,
            ),
            _buildDetailRow(
              label: 'Delivery Date',
              value: deliveryDateStr,
              valueColor: deliveryColor,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 15),

            // Action Button (Smart & Prominent)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: po.id == null ? null : () => _viewFullPO(context, po.id),
                icon: const Icon(Icons.search),
                label: const Text(
                  'VIEW FULL PO',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: POPalette.actionButton,
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
      backgroundColor: POPalette.background,
      appBar: AppBar(
        title: const Text(
          'Active Purchase Orders',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: POPalette.primary, // Red AppBar
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              // TODO: Implement Add PO functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Create New PO Form')),
              );
            },
            tooltip: 'Create New PO',
          )
        ],
      ),
      body: FutureBuilder<List<PurchaseOrder>>(
        future: _purchaseOrderListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: POPalette.primary),
            );
          } else if (snapshot.hasError) {
            // Fabulous Error State
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_off, color: POPalette.primary, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      "Failed to load Purchase Orders. Server unreachable.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: POPalette.primary, fontSize: 16),
                    ),
                    Text('Error: ${snapshot.error}', style: const TextStyle(fontSize: 12, color: POPalette.secondaryText)),
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
                  Icon(Icons.assignment_turned_in_outlined, color: POPalette.secondaryText, size: 50),
                  SizedBox(height: 10),
                  Text('No open Purchase Orders found.', style: TextStyle(fontSize: 18, color: POPalette.secondaryText)),
                ],
              ),
            );
          } else {
            final purchase = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: purchase.length,
              itemBuilder: (context, index) {
                return _buildPOCard(context, purchase[index]);
              },
            );
          }
        },
      ),
    );
  }
}