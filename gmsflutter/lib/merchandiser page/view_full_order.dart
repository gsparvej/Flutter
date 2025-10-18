import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/order.dart';
import 'package:intl/intl.dart';

// --- Color and Style Palette ---
class OrderFullPalette {
  static const Color primary = Color(0xFF673AB7); // Deep Purple
  static const Color secondary = Color(0xFF00BFA5); // Teal - Dates/Metrics
  static const Color accent = Color(0xFFFF9800); // Orange - Status
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryText = Color(0xFF263238);
  static const Color secondaryText = Color(0xFF757575);
  static const Color totalColor = Color(0xFFE53935); // Red - Total Cost
  static const Color paidColor = Color(0xFF4CAF50); // Green - Paid Amount
  static const Color dueColor = Color(0xFFFDD835); // Yellow - Due Amount
}

class ViewFullOrder extends StatelessWidget {
  final Order order;

  const ViewFullOrder({Key? key, required this.order}) : super(key: key);

  // Helper function to safely display and format values
  String displayValue(dynamic value, {bool isCurrency = false}) {
    if (value == null) return 'N/A';
    if (value is String && value.trim().isEmpty) return 'N/A';
    if (value is double || value is int) {
      if (isCurrency) {
        // Formats as currency string (e.g., $1,234.56 or 1,234.56)
        final formatter = NumberFormat('#,##0.00');
        return formatter.format(value);
      }
      return value.toString();
    }
    return value.toString();
  }

  // Helper to format Date Strings
  String formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.trim().isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr).toLocal();
      final formatter = DateFormat('dd MMM yyyy, hh:mm a'); // e.g., 15 Oct 2025, 04:00 PM
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

  // Gorgeous Section Builder
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: OrderFullPalette.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: const Border(left: BorderSide(color: OrderFullPalette.primary, width: 4)),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: OrderFullPalette.primaryText,
          ),
        ),
      ),
    );
  }

  // Smart Detail Row Builder
  Widget _buildDetailRow(String label, dynamic value, {Color? valueColor, FontWeight fontWeight = FontWeight.normal}) {
    final display = displayValue(value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: OrderFullPalette.secondaryText,
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
                color: valueColor ?? OrderFullPalette.primaryText,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fabulous Size/Price Row Builder
  Widget _buildSizePriceRow(String sizeLabel, dynamic size, dynamic price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              sizeLabel,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: OrderFullPalette.primary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: _buildDetailRow("Quantity", size, fontWeight: FontWeight.bold),
          ),
          Expanded(
            flex: 3,
            child: _buildDetailRow("Unit Price", price, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrderFullPalette.background,
      appBar: AppBar(
        title: const Text(
          'Complete Order Details',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: OrderFullPalette.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 10, // Fabulous elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Top Header (Buyer Name & Order ID) ---
                Center(
                  child: Text(
                    displayValue(order.buyer?.name).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: OrderFullPalette.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "ORDER ID: ${displayValue(order.id)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: OrderFullPalette.accent,
                    ),
                  ),
                ),
                const Divider(height: 25, thickness: 1.5),

                // --- 1. General Info Section ---
                _buildSectionHeader("Order & Style Information"),
                _buildDetailRow("Order Date", formatLocalDate(order.orderDate), valueColor: OrderFullPalette.primaryText),
                _buildDetailRow("Delivery Date", formatLocalDate(order.deliveryDate), valueColor: OrderFullPalette.secondary),
                _buildDetailRow("Style Code", displayValue(order.bomStyle?.styleCode), fontWeight: FontWeight.bold),
                _buildDetailRow("Order Status", displayValue(order.orderStatus), valueColor: OrderFullPalette.accent),
                _buildDetailRow("Remarks", displayValue(order.remarks)),

                // --- 2. Short Sleeve Sizes Section ---
                _buildSectionHeader("Short Sleeve Sizes (Quantity & Price)"),
                _buildSizePriceRow("S", order.shortSmallSize, order.shortSPrice),
                _buildSizePriceRow("M", order.shortMediumSize, order.shortMPrice),
                _buildSizePriceRow("L", order.shortLargeSize, order.shortLPrice),
                _buildSizePriceRow("XL", order.shortXLSize, order.shortXLPrice),

                // --- 3. Full Sleeve Sizes Section ---
                _buildSectionHeader("Full Sleeve Sizes (Quantity & Price)"),
                _buildSizePriceRow("S", order.fullSmallSize, order.fullSPrice),
                _buildSizePriceRow("M", order.fullMediumSize, order.fullMPrice),
                _buildSizePriceRow("L", order.fullLargeSize, order.fullLPrice),
                _buildSizePriceRow("XL", order.fullXLSize, order.fullXLPrice),

                // --- 4. Financial Summary Section (Gorgeous and Colorful) ---
                _buildSectionHeader("Financial Summary"),

                // Use isCurrency: true for financial values
                _buildDetailRow("Sub Total", displayValue(order.subTotal, isCurrency: true)),
                _buildDetailRow("VAT", displayValue(order.vat, isCurrency: true)),
                _buildDetailRow("Paid Amount", displayValue(order.paidAmount, isCurrency: true), valueColor: OrderFullPalette.paidColor, fontWeight: FontWeight.bold),
                _buildDetailRow("Due Amount", displayValue(order.dueAmount, isCurrency: true), valueColor: OrderFullPalette.dueColor, fontWeight: FontWeight.bold),

                const Divider(height: 20, thickness: 2, color: OrderFullPalette.primary),

                // Total Highlight
                _buildDetailRow("GRAND TOTAL", displayValue(order.total, isCurrency: true), valueColor: OrderFullPalette.totalColor, fontWeight: FontWeight.w900),
              ],
            ),
          ),
        ),
      ),
    );
  }
}