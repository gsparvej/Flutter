import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/purchase_order.dart';
import 'package:intl/intl.dart';

// --- Theme Constants (For better Aesthetics) ---
const Color kPrimaryColor = Color(0xFF4A148C); // Deep Purple 900
const Color kAccentColor = Color(0xFFF5B041); // A warm accent color (Orange/Gold)
const Color kBackgroundColor = Color(0xFFF0F0F0); // Light background
const Color kDetailBackgroundColor = Colors.white; // White card background
const Color kLabelColor = Color(0xFF6A1B9A); // A lighter purple for labels

class ViewFullPO extends StatelessWidget {
  final PurchaseOrder purchase;

  const ViewFullPO({Key? key, required this.purchase}) : super(key: key);

  String displayValue(dynamic value) {
    if (value == null) return 'N/A';
    if (value is String && value.trim().isEmpty) return 'N/A';
    return value.toString();
  }

  // Helper for formatting dates
  String formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.trim().isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr);
      // Change format for a cleaner look
      final formatter = DateFormat.yMMMd('en_US'); // e.g. Oct 12, 2025
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set the overall Scaffold background to the light color
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Purchase Order Details'),
        backgroundColor: kPrimaryColor, // Use the deep purple
        foregroundColor: kDetailBackgroundColor, // White text
        elevation: 0, // Flat design for app bar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Main Card for PO Details
              Card(
                color: kDetailBackgroundColor,
                elevation: 8, // Increased elevation for a floating effect
                shadowColor: kPrimaryColor.withOpacity(0.3), // Subtle purple shadow
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Header Section ---
                      Center(
                        child: Text(
                          displayValue(purchase.item?.categoryName),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: kPrimaryColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Divider(height: 30, thickness: 1.5, color: kBackgroundColor),

                      // --- Financial & Primary Details Section ---
                      buildSectionHeader(Icons.shopping_cart, "Order Information"),
                      const SizedBox(height: 8),
                      buildRow("PO Number", displayValue(purchase.poNumber), isHighlight: true),
                      buildRow("PO Date", formatLocalDate(purchase.poDate)),
                      buildRow("Delivery Date", formatLocalDate(purchase.deliveryDate)),

                      const Divider(height: 30, thickness: 1, color: kBackgroundColor),

                      buildSectionHeader(Icons.monetization_on, "Financial Summary"),
                      const SizedBox(height: 8),
                      buildRow("Quantity", displayValue(purchase.quantity)),
                      buildRow("Tax(%)", displayValue(purchase.tax)),
                      buildRow("Sub Total", displayValue(purchase.subTotal), isHighlight: true),
                      // Highlight the total amount
                      buildRow("Total Amount", displayValue(purchase.totalAmount), isTotal: true),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Vendor Details Card
              Card(
                color: kDetailBackgroundColor,
                elevation: 8,
                shadowColor: kPrimaryColor.withOpacity(0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionHeader(Icons.person, "Vendor Details"),
                      const SizedBox(height: 8),
                      buildRow("Vendor Name", displayValue(purchase.vendor?.companyName)),
                      buildRow("Contact Person", displayValue(purchase.vendor?.contactPerson)),
                      buildRow("Contact Number", displayValue(purchase.vendor?.phone)),
                      buildRow("Vendor Address", displayValue(purchase.vendor?.address)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Terms and Conditions Card
              Card(
                color: kDetailBackgroundColor,
                elevation: 8,
                shadowColor: kPrimaryColor.withOpacity(0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionHeader(Icons.description, "Terms & Conditions"),
                      const SizedBox(height: 12),
                      Text(
                        displayValue(purchase.termsAndCondition),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // New widget to create visual section breaks
  Widget buildSectionHeader(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Row(
        children: [
          Icon(icon, color: kPrimaryColor, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Enhanced buildRow with conditional styling
  Widget buildRow(String label, String value, {bool isHighlight = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600, // Slightly bolder label
                color: kLabelColor, // Custom color for labels
                fontSize: isTotal ? 16 : 14,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.w900 : (isHighlight ? FontWeight.bold : FontWeight.normal),
                color: isTotal ? kAccentColor : Colors.black87, // Accent color for total
                fontSize: isTotal ? 18 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}