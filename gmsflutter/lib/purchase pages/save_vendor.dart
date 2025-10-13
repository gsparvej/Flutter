import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/vendor.dart';
import 'package:gmsflutter/service/purchase_service/vendor_service.dart';

class SaveVendor extends StatefulWidget {
  const SaveVendor({super.key});

  @override
  State<SaveVendor> createState() => _SaveVendorState();
}

class _SaveVendorState extends State<SaveVendor> {
  final VendorService vendorService = VendorService();

  final _vendorNameController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _tinController = TextEditingController();
  final _binController = TextEditingController();
  final _vatController = TextEditingController();

  Future<void> saveVendor() async {
    if (_vendorNameController.text.isEmpty ||
        _contactPersonController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty ||
        (_tinController.text.isEmpty && _binController.text.isEmpty && _vatController.text.isEmpty)) {
      // Show error or return
    }
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill the required fields properly'),
        ),
      );
      return;
    }

    final vendor = Vendor(
      vendorName: _vendorNameController.text,
      companyName: _vendorNameController.text,
      contactPerson: _contactPersonController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      tin: _tinController.text,
      bin: _binController.text,
      vat: _vatController.text,
    );

    print(vendor.toJson()); // Debug log

    bool success = await vendorService.addVendor(vendor);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Vendor Saved Successfully' : 'Failed to Save'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    if (success) {
      // Optionally clear form after success
      _vendorNameController.clear();
      _contactPersonController.clear();
      _emailController.clear();
      _phoneController.clear();
      _addressController.clear();
      _tinController.clear();
      _binController.clear();
      _vatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Vendor")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _vendorNameController,
              decoration: const InputDecoration(labelText: 'Vendor Company Name'),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _contactPersonController,
              decoration: const InputDecoration(labelText: 'Contact person'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Company Address'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tinController,
              decoration: const InputDecoration(labelText: 'TIN Number (if)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _binController,
              decoration: const InputDecoration(labelText: 'BIN Number (if)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _vatController,
              decoration: const InputDecoration(labelText: 'VAT Number (if)'),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveVendor,
              child: const Text('Save Vendor'),
            ),
          ],
        ),
      ),
    );
  }
}
