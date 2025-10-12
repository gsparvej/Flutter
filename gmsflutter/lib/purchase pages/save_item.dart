import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/item.dart';
import 'package:gmsflutter/service/purchase_service/item_service.dart';

class SaveItem extends StatefulWidget {
  const SaveItem({super.key});

  @override
  State<SaveItem> createState() => _SaveItemState();
}

class _SaveItemState extends State<SaveItem> {
  final ItemService itemService = ItemService();

  final _categoryNameController = TextEditingController();
  final _unitController = TextEditingController();

  Future<void> saveItem() async {
    if (_categoryNameController.text.isEmpty || _unitController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields properly'),
        ),
      );
      return;
    }

    final item = Item(
      categoryName: _categoryNameController.text,
      unit: _unitController.text,
    );

    print(item.toJson()); // Debug log

    bool success = await itemService.addItem(item);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Item Saved Successfully' : 'Failed to Save'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    if (success) {
      // Optionally clear form after success
      _categoryNameController.clear();
      _unitController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _categoryNameController,
              decoration: const InputDecoration(labelText: 'Item Category Name'),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _unitController,
              decoration: const InputDecoration(labelText: 'Unit'),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveItem,
              child: const Text('Save Item'),
            ),
          ],
        ),
      ),
    );
  }
}
