import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/inventory.dart';
import 'package:gmsflutter/service/purchase_service/inventory_service.dart';

class ViewInventory extends StatefulWidget {
  const ViewInventory({Key? key}) : super(key: key);

  @override
  State<ViewInventory> createState() => _ViewInventoryState();
}

class _ViewInventoryState extends State<ViewInventory> {
  late Future<List<Inventory>> inventoryList;

  @override
  void initState() {
    super.initState();
    inventoryList = InventoryService().fetchInventories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        // Adding consistent styling
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Inventory>>(
        future: inventoryList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
          } else if (snapshot.hasError) {
            // Updated error display for better user feedback
            return const Center(child: Text('Inventory Data Unavailable', style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle case where data is successfully fetched but empty
            return const Center(child: Text('No Inventory Data Available'));
          }
          else {
            final inventory = snapshot.data!;
            return ListView.builder(
              itemCount: inventory.length,
              itemBuilder: (context, index) {
                final inven = inventory[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 4, // Added elevation for aesthetics
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      ("Category Name: ${inven.categoryName}"),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.deepPurple, // Highlight category name
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        // Displaying quantity with bold label
                        if (inven.quantity != null)
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14),
                              children: <TextSpan>[
                                const TextSpan(text: "Quantity: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                                TextSpan(text: "${inven.quantity}", style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
