import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/buyer.dart';
import 'package:gmsflutter/service/merchandiser_service/buyer_service.dart';

// Define the primary color palette for a vibrant look
const Color kPrimaryColor = Color(0xFF1E88E5); // Blue 600
const Color kAccentColor = Color(0xFFFFB74D); // Amber 300
const Color kBackgroundColor = Color(0xFFF5F5F5); // Light Gray

class SaveBuyer extends StatefulWidget {
  const SaveBuyer({super.key});

  @override
  State<SaveBuyer> createState() => _SaveBuyerState();
}

class _SaveBuyerState extends State<SaveBuyer> {
  final BuyerService buyerService = BuyerService();
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _buyerNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _websiteController = TextEditingController();

  // State to manage the loading indicator
  bool _isLoading = false;

  @override
  void dispose() {
    _buyerNameController.dispose();
    _countryController.dispose();
    _contactPersonController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  Future<void> _saveBuyer() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true; // Start loading indicator
    });

    final buyer = Buyer(
      name: _buyerNameController.text.trim(),
      country: _countryController.text.trim(),
      contactPerson: _contactPersonController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      website: _websiteController.text.trim(),
    );

    try {
      bool result = await buyerService.addBuyer(buyer);

      if (context.mounted) {
        // Show success/failure feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result ? 'Buyer saved successfully!' : 'Failed to save buyer. Check service implementation.',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: result ? Colors.green.shade600 : Colors.red.shade600,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );

        if (result) {
          // *** This line resets the form fields after a successful save. ***
          _formKey.currentState!.reset();
        }
      }
    } catch (e) {
      if (context.mounted) {
        // Handle unexpected exceptions during the service call
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: ${e.toString()}'),
            backgroundColor: Colors.red.shade900,
            duration: const Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (context.mounted) {
        setState(() {
          _isLoading = false; // Stop loading indicator
        });
      }
    }
  }

  // Helper widget for a styled text field with an icon
  Widget _buildIconTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: kPrimaryColor.withOpacity(0.8)),
          prefixIcon: Icon(icon, color: kPrimaryColor),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none, // Hide default border for a cleaner look
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: kPrimaryColor.withOpacity(0.3), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.5),
          ),
        ),
        validator: validator,
      ),
    );
  }

  // Email validator helper function
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Required field validator helper function
  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Add New Partner',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // A subtle card to contain the form, giving it depth
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Form Fields
                      _buildIconTextField(
                        label: 'Buyer Name',
                        controller: _buyerNameController,
                        icon: Icons.business,
                        validator: (value) => _requiredValidator(value, 'Buyer Name'),
                      ),
                      _buildIconTextField(
                        label: 'Country',
                        controller: _countryController,
                        icon: Icons.flag,
                        validator: (value) => _requiredValidator(value, 'Country'),
                      ),
                      _buildIconTextField(
                        label: 'Contact Person',
                        controller: _contactPersonController,
                        icon: Icons.person,
                        validator: (value) => _requiredValidator(value, 'Contact Person'),
                      ),
                      _buildIconTextField(
                        label: 'Email Address',
                        controller: _emailController,
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
                      ),
                      _buildIconTextField(
                        label: 'Phone Number',
                        controller: _phoneController,
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) => _requiredValidator(value, 'Phone'),
                      ),
                      _buildIconTextField(
                        label: 'Address',
                        controller: _addressController,
                        icon: Icons.location_on,
                        maxLines: 3,
                        validator: (value) => _requiredValidator(value, 'Address'),
                      ),
                      _buildIconTextField(
                        label: 'Website URL',
                        controller: _websiteController,
                        icon: Icons.language,
                        keyboardType: TextInputType.url,
                        validator: (value) => _requiredValidator(value, 'Website'),
                      ),
                      const SizedBox(height: 30),

                      // Save Button with Loading State
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _isLoading ? null : _saveBuyer,
                          icon: _isLoading
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          )
                              : const Icon(Icons.save_rounded, size: 24),
                          label: Text(
                            _isLoading ? 'SAVING...' : 'SAVE BUYER',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: kAccentColor, // Use the accent color for the button
                            foregroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
