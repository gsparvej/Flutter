import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/item.dart';
import 'package:gmsflutter/service/purchase_service/item_service.dart';

// --- Color and Style Palette (Grey & Teal) ---
class ItemPalette {
  static const Color primary = Color(0xFF00796B); // Deep Teal - Professional/Inventory
  static const Color accent = Color(0xFF80CBC4); // Light Teal - Metric Highlight
  static const Color cardBackground = Colors.white;
  static const Color background = Color(0xFFF5F5F5); // Light Grey Background
  static const Color primaryText = Color(0xFF263238);
  static const Color secondaryText = Color(0xFF757575);
  static const Color errorColor = Color(0xFFD32F2F);
}

class ViewItem extends StatefulWidget {
  const ViewItem({Key? key}) : super(key: key);

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  late Future<List<Item>> _itemListFuture;

  @override
  void initState() {
    super.initState();
    _itemListFuture = ItemService().fetchItems();
  }

  // Helper method to safely display a value
  String displayValue(String? value) {
    return (value == null || value.trim().isEmpty) ? 'N/A' : value;
  }

  // --- Widget Builders ---

  Widget _buildItemCard(BuildContext context, Item item) {
    final categoryName = displayValue(item.categoryName);
    final unit = displayValue(item.unit);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6, // Fabulous elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        // Subtle border accent
        side: BorderSide(color: ItemPalette.primary.withOpacity(0.3), width: 1.5),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation to item detail/edit page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Viewing items in category: $categoryName')),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Container (Colorful Accent)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ItemPalette.accent.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.category_outlined,
                  color: ItemPalette.primary,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),

              // Title and Subtitle (Smart)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: ItemPalette.primaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Unit Information (Subtle Metric)
                    Row(
                      children: [
                        const Icon(Icons.square_foot, size: 14, color: ItemPalette.secondaryText),
                        const SizedBox(width: 4),
                        Text(
                          "Unit: $unit",
                          style: TextStyle(
                            fontSize: 14,
                            color: ItemPalette.secondaryText,
                            fontWeight: unit == 'N/A' ? FontWeight.normal : FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Trailing Arrow
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: ItemPalette.secondaryText,
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
      backgroundColor: ItemPalette.background,
      appBar: AppBar(
        title: const Text(
          'Inventory Item Categories',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: ItemPalette.primary, // Colorful AppBar
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // TODO: Implement Add Item functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Add Item Form')),
              );
            },
            tooltip: 'Add New Item',
          )
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: _itemListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: ItemPalette.primary),
            );
          } else if (snapshot.hasError || !snapshot.hasData) {
            // Fabulous Error/Empty State
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: ItemPalette.errorColor, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      snapshot.hasError ? 'Error loading item data. Please retry.' : 'No Item Categories Found.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ItemPalette.errorColor, fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            // Specific Empty State for no data but no error
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, color: ItemPalette.secondaryText, size: 50),
                  SizedBox(height: 10),
                  Text('No Item Categories Available.', style: TextStyle(fontSize: 18, color: ItemPalette.secondaryText)),
                ],
              ),
            );
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildItemCard(context, items[index]);
              },
            );
          }
        },
      ),
    );
  }
}