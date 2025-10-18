import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/vendor.dart';
import 'package:gmsflutter/service/purchase_service/vendor_service.dart';

// --- Styling Constants for Consistency ---
const Color _primaryColor = Colors.deepPurple;
const Color _successColor = Colors.green;
const Color _errorColor = Colors.red;

class SaveVendor extends StatefulWidget {
  const SaveVendor({super.key});

  @override
  State<SaveVendor> createState() => _SaveVendorState();
}

class _SaveVendorState extends State<SaveVendor> {
  final VendorService vendorService = VendorService();

  // Controllers for all form fields
  final _vendorNameController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _tinController = TextEditingController();
  final _binController = TextEditingController();
  final _vatController = TextEditingController();

  // IMPORTANT: Dispose of all controllers to prevent memory leaks
  @override
  void dispose() {
    _vendorNameController.dispose();
    _contactPersonController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _tinController.dispose();
    _binController.dispose();
    _vatController.dispose();
    super.dispose();
  }

  Future<void> saveVendor() async {
    // 1. Validation Check: Required fields
    if (_vendorNameController.text.isEmpty ||
        _contactPersonController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields (Name, Contact, Email, Phone, Address).'),
          backgroundColor: _errorColor,
        ),
      );
      return;
    }

    // 2. Validation Check: At least one registration number
    if (_tinController.text.isEmpty &&
        _binController.text.isEmpty &&
        _vatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide at least one registration number (TIN, BIN, or VAT).'),
          backgroundColor: _errorColor,
        ),
      );
      return;
    }

    // 3. Data Preparation (Trimming whitespace)
    final vendor = Vendor(
      vendorName: _vendorNameController.text.trim(),
      companyName: _vendorNameController.text.trim(),
      contactPerson: _contactPersonController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      tin: _tinController.text.trim(),
      bin: _binController.text.trim(),
      vat: _vatController.text.trim(),
    );

    print("Attempting to save vendor: ${vendor.toJson()}");

    // 4. API Call
    bool success = await vendorService.addVendor(vendor);

    // 5. Feedback and Cleanup
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Vendor Saved Successfully' : 'Failed to Save Vendor.'),
        backgroundColor: success ? _successColor : _errorColor,
      ),
    );

    if (success) {
      // Clear form after success
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

  // Helper function for consistent TextField styling
  Widget _buildVendorTextField(
      TextEditingController controller,
      String label,
      String hint, {
        TextInputType keyboardType = TextInputType.text,
        int maxLines = 1,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: _primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildSizedBox() => const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Vendor"),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text(
              "Register a new supplier.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: _primaryColor),
            ),
            const SizedBox(height: 24),

            // --- Contact and Address Details ---
            _buildVendorTextField(_vendorNameController, 'Vendor Company Name (Required)', 'e.g., Tech Supply Corp'),
            _buildSizedBox(),
            _buildVendorTextField(_contactPersonController, 'Contact Person (Required)', 'e.g., Jane Doe'),
            _buildSizedBox(),
            _buildVendorTextField(_phoneController, 'Phone Number (Required)', 'e.g., +123 456 7890', keyboardType: TextInputType.phone),
            _buildSizedBox(),
            _buildVendorTextField(_emailController, 'Email Address (Required)', 'e.g., contact@techsupply.com', keyboardType: TextInputType.emailAddress),
            _buildSizedBox(),
            _buildVendorTextField(_addressController, 'Company Address (Required)', 'Street, City, Postcode', maxLines: 2),
            _buildSizedBox(),

            // --- Registration Numbers Header ---
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Registration Details (TIN, BIN, or VAT - One is required)",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
              ),
            ),

            // --- Registration Number Fields ---
            _buildVendorTextField(_tinController, 'TIN Number (Optional)', ''),
            _buildSizedBox(),
            _buildVendorTextField(_binController, 'BIN Number (Optional)', ''),
            _buildSizedBox(),
            _buildVendorTextField(_vatController, 'VAT Number (Optional)', ''),

            const SizedBox(height: 30),

            // --- Save Button ---
            ElevatedButton(
              onPressed: saveVendor,
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
                'Save Vendor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
