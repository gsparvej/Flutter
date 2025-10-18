import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/item.dart';
import 'package:gmsflutter/service/purchase_service/item_service.dart';

// --- Styling Constants for Consistency ---
const Color _primaryColor = Colors.deepPurple;
const Color _successColor = Colors.green;
const Color _errorColor = Colors.red;

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
    // 1. Validation Check
    if (_categoryNameController.text.isEmpty || _unitController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields.'),
          backgroundColor: _errorColor,
        ),
      );
      return;
    }

    // 2. Data Preparation
    final item = Item(
      categoryName: _categoryNameController.text.trim(),
      unit: _unitController.text.trim(),
    );

    print("Attempting to save item: ${item.toJson()}");

    // 3. API Call
    bool success = await itemService.addItem(item);

    // 4. Feedback and Cleanup
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Item Saved Successfully' : 'Failed to Save Item.'),
        backgroundColor: success ? _successColor : _errorColor,
      ),
    );

    if (success) {
      // Clear form after successful submission
      _categoryNameController.clear();
      _unitController.clear();
    }
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Item"),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            // Title and Description
            const Text(
              "Define a new inventory item.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: _primaryColor),
            ),
            const SizedBox(height: 24),

            // Item Category Name Field
            TextField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                labelText: 'Item Category Name',
                hintText: 'e.g., Screws, Laptops, Safety Gloves',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: _primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Unit Field
            TextField(
              controller: _unitController,
              decoration: InputDecoration(
                labelText: 'Unit of Measure',
                hintText: 'e.g., Pcs, Box, Kg, Liter',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: _primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Save Button
            ElevatedButton(
              onPressed: saveItem,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Save Item',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
