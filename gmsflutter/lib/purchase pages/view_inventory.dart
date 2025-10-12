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
      appBar: AppBar(title: const Text('Inventory')),
      body: FutureBuilder<List<Inventory>>(
        future: inventoryList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('UnAvailabe'));
          } else {
            final inventory = snapshot.data!;
            return ListView.builder(
              itemCount: inventory.length,
              itemBuilder: (context, index) {
                final inven = inventory[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      ("Category Name: ${inven.categoryName}"),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (inven.quantity != null)
                          Text("Quantity: ${inven.quantity}")
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
