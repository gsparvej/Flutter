import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/buyer.dart';
import 'package:gmsflutter/service/merchandiser_service/buyer_service.dart';

// --- Color and Style Palette ---
class BuyerPalette {
  static const Color primary = Color(0xFF00796B); // Teal - Professional and fresh
  static const Color accent = Color(0xFFFFB300); // Amber - Energy
  static const Color cardBackground = Colors.white;
  static const Color primaryText = Color(0xFF263238);
  static const Color secondaryText = Color(0xFF757575);
}

class ViewBuyer extends StatefulWidget {
  const ViewBuyer({Key? key}) : super(key: key);

  @override
  State<ViewBuyer> createState() => _BuyerDetailsState();
}

class _BuyerDetailsState extends State<ViewBuyer> {
  late Future<List<Buyer>> _buyerListFuture;

  @override
  void initState() {
    super.initState();
    _buyerListFuture = BuyerService().fetchBuyers();
  }

  // --- Widget Builders ---

  Widget _buildBuyerCard(BuildContext context, Buyer buyer) {
    // Smart: Provide a default name if null
    final buyerName = buyer.name?.toUpperCase() ?? "UNKNOWN BUYER";

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 8, // Fabulous elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation to Buyer details page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Viewing details for $buyerName')),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Buyer Name Header (Colorful & Fabulous)
              Text(
                buyerName,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: BuyerPalette.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(height: 16, thickness: 1),

              // Contact Details Grid (Smart Layout)
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 4.5, // Control item height
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 10,
                children: [
                  _buildDetailItem(
                    icon: Icons.person_outline,
                    label: 'Contact Person',
                    value: buyer.contactPerson,
                  ),
                  _buildDetailItem(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: buyer.phone,
                  ),
                  _buildDetailItem(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: buyer.email,
                  ),
                  _buildDetailItem(
                    icon: Icons.public,
                    label: 'Country',
                    value: buyer.country,
                  ),
                ].where((widget) => widget != null).cast<Widget>().toList(), // Filter out nulls
              ),

              const SizedBox(height: 10),

              // Action Indicator
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: BuyerPalette.primary.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({required IconData icon, required String label, String? value}) {
    if (value == null || value.isEmpty) return Container(); // Smartly hides empty fields

    return Row(
      children: [
        Icon(icon, size: 18, color: BuyerPalette.primary.withOpacity(0.7)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: BuyerPalette.primaryText,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BuyerPalette.cardBackground.withOpacity(0.95), // Light background for contrast
      appBar: AppBar(
        title: const Text(
          'Global Buyer Directory',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: BuyerPalette.primary, // Colorful AppBar
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // TODO: Implement Add Buyer functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Add Buyer Form')),
              );
            },
            tooltip: 'Add New Buyer',
          )
        ],
      ),
      body: FutureBuilder<List<Buyer>>(
        future: _buyerListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: BuyerPalette.primary),
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
                      "Failed to load buyers. Check server connection.",
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
                  Icon(Icons.inventory_2_outlined, color: BuyerPalette.secondaryText, size: 50),
                  SizedBox(height: 10),
                  Text('No buyers currently registered.', style: TextStyle(fontSize: 18, color: BuyerPalette.secondaryText)),
                ],
              ),
            );
          } else {
            final buyers = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: buyers.length,
              itemBuilder: (context, index) {
                return _buildBuyerCard(context, buyers[index]);
              },
            );
          }
        },
      ),
    );
  }
}