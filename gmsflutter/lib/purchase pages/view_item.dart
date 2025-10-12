import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/item.dart';
import 'package:gmsflutter/service/purchase_service/item_service.dart';

class ViewItem extends StatefulWidget {

  const ViewItem({Key? key}) : super(key: key);

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  late Future<List<Item>> itemList;

  @override
  void initState() {
    super.initState();
    itemList = ItemService().fetchItems();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Item List')),
      body: FutureBuilder<List<Item>>(
        future: itemList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('No Item List Availabe'));
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final u = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      ("Category Name: ${u.categoryName}"),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (u.unit != null)
                          Text("Product Unit: ${u.unit}")
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
