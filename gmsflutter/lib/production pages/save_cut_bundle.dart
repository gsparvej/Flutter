import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_entities/cut_bundle.dart';
import 'package:gmsflutter/entity/production_entities/cutting_plan.dart';
import 'package:gmsflutter/service/production_service/cut_bundle_service.dart';


class SaveCutBundle extends StatefulWidget {
  const SaveCutBundle({super.key});

  @override
  State<SaveCutBundle> createState() => _SaveCutBundleState();
}

class _SaveCutBundleState extends State<SaveCutBundle> {
  final CutBundleService cutBundleService = CutBundleService();

  List<CuttingPlan> cuttingPlan = [];
  CuttingPlan? selectedCuttingPlan;

  final _bundleNoController = TextEditingController();
  final _colorController = TextEditingController();
  final _plannedQtyController = TextEditingController();
  final _cutBundleDateController = TextEditingController();

  // Size dropdown options
  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL']; // Added XXL for completeness
  String? selectedSize;

  // Styling constants for consistency
  static const Color _primaryColor = Colors.deepPurple;
  static const Color _successColor = Colors.green;
  static const Color _errorColor = Colors.red;

  @override
  void initState() {
    super.initState();
    loadCuttingPlan();
  }

  @override
  void dispose() {
    _bundleNoController.dispose();
    _colorController.dispose();
    _plannedQtyController.dispose();
    _cutBundleDateController.dispose();
    super.dispose();
  }

  Future<void> loadCuttingPlan() async {
    try {
      final plans = await cutBundleService.getCuttingPlan();
      if (mounted) {
        setState(() {
          cuttingPlan = plans;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load cutting plans: $e'), backgroundColor: _errorColor),
        );
      }
    }
  }

  // Helper for consistent InputDecoration styling
  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: _primaryColor, width: 2),
      ),
    );
  }

  Future<void> saveCutBundle() async {
    // Basic validation check
    if (selectedCuttingPlan == null ||
        _bundleNoController.text.isEmpty ||
        selectedSize == null ||
        _colorController.text.isEmpty ||
        _plannedQtyController.text.isEmpty ||
        _cutBundleDateController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all required fields properly'),
            backgroundColor: _errorColor,
          ),
        );
      }
      return;
    }

    final cutBundle = CutBundle(
      bundleNo: _bundleNoController.text.trim(),
      size: selectedSize ?? '',
      color: _colorController.text.trim(),
      plannedQty: int.tryParse(_plannedQtyController.text.trim()) ?? 0,
      cutBundleDate: _cutBundleDateController.text,
      cuttingPlanId: selectedCuttingPlan!.id!,
    );

    print(cutBundle.toJson()); // Debug log

    bool success = await cutBundleService.addCutBundle(cutBundle);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? 'Cut Bundle Saved Successfully' : 'Failed to Save',
          ),
          backgroundColor: success ? _successColor : _errorColor,
        ),
      );
    }

    if (success && mounted) {
      // Clear form after success
      _bundleNoController.clear();
      _colorController.clear();
      _plannedQtyController.clear();
      _cutBundleDateController.clear();
      setState(() {
        selectedSize = null;
        selectedCuttingPlan = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Cut Bundle"),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Cutting Plan Dropdown
            DropdownButtonFormField<CuttingPlan>(
              value: selectedCuttingPlan,
              decoration: _buildInputDecoration('Cutting Plan ID'),
              items: cuttingPlan.map((c) {
                return DropdownMenuItem(
                  value: c,
                  // Display a more meaningful identifier if available, otherwise use ID
                  child: Text('Plan ID: ${c.id.toString()}'),
                );
              }).toList(),
              onChanged: (val) {
                setState(() => selectedCuttingPlan = val);
              },
              validator: (value) => value == null ? 'Please select a Cutting Plan' : null,
            ),
            const SizedBox(height: 16),

            // Bundle No
            TextField(
              controller: _bundleNoController,
              decoration: _buildInputDecoration('Cut Bundle No'),
            ),

            const SizedBox(height: 16),

            // Size Dropdown
            DropdownButtonFormField<String>(
              value: selectedSize,
              decoration: _buildInputDecoration('Size'),
              items: sizes.map((size) {
                return DropdownMenuItem(value: size, child: Text(size));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSize = value;
                });
              },
              validator: (value) => value == null ? 'Please select a Size' : null,
            ),

            const SizedBox(height: 16),

            // Color
            TextField(
              controller: _colorController,
              decoration: _buildInputDecoration('Color'),
            ),

            const SizedBox(height: 16),

            // Planned Quantity
            TextField(
              controller: _plannedQtyController,
              keyboardType: TextInputType.number,
              decoration: _buildInputDecoration('Planned Quantity'),
            ),

            const SizedBox(height: 16),

            // Cut Bundle Date
            DateTimeFormField(
              decoration: _buildInputDecoration("Cut Bundle Date"),
              mode: DateTimeFieldPickerMode.date,
              onChanged: (DateTime? value) {
                if (value != null) {
                  // Format the date to a standard string format before saving
                  _cutBundleDateController.text = value.toIso8601String().substring(0, 10);
                }
              },
            ),

            const SizedBox(height: 24),

            // Save Button
            ElevatedButton(
              onPressed: saveCutBundle,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 3,
              ),
              child: const Text('Save Cut Bundle', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
