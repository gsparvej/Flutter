import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_part/cut_bundle.dart';
import 'package:gmsflutter/entity/production_part/cutting_plan.dart';
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

  // ✅ Size dropdown
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    loadCuttingPlan();
  }

  Future<void> loadCuttingPlan() async {
    cuttingPlan = await cutBundleService.getCuttingPlan();
    setState(() {});
  }

  Future<void> saveCutBundle() async {
    if (selectedCuttingPlan == null ||
        _bundleNoController.text.isEmpty ||
        selectedSize == null ||
        _colorController.text.isEmpty ||
        _plannedQtyController.text.isEmpty ||
        _cutBundleDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields properly'),
        ),
      );
      return;
    }

    final cutBundle = CutBundle(
      bundleNo: _bundleNoController.text,
      size: selectedSize ?? '',
      color: _colorController.text,
      plannedQty: int.tryParse(_plannedQtyController.text) ?? 0,
      cutBundleDate: _cutBundleDateController.text,
      cuttingPlanId: selectedCuttingPlan!.id!, // ✅ Correct way
    );

    print(cutBundle.toJson()); // Debug log

    bool success = await cutBundleService.addCutBundle(cutBundle);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Cut Bundle Saved Successfully' : 'Failed to Save',
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    if (success) {
      // Optionally clear form after success
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
      appBar: AppBar(title: const Text("Add Cut Bundle")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DropdownButtonFormField<CuttingPlan>(
              value: selectedCuttingPlan,
              decoration: const InputDecoration(labelText: 'Cutting Plan ID'),
              items: cuttingPlan.map((c) {
                return DropdownMenuItem(value: c, child: Text(c.id.toString()));
              }).toList(),
              onChanged: (val) {
                setState(() => selectedCuttingPlan = val);
              },
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _bundleNoController,
              decoration: const InputDecoration(labelText: 'Cut Bundle No'),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: selectedSize,
              decoration: const InputDecoration(labelText: 'Size'),
              items: sizes.map((size) {
                return DropdownMenuItem(value: size, child: Text(size));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSize = value;
                });
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _plannedQtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Planned Quantity'),
            ),

            const SizedBox(height: 16),

            DateTimeFormField(
              decoration: const InputDecoration(labelText: "Cut Bundle Date"),
              mode: DateTimeFieldPickerMode.date,
              onChanged: (DateTime? value) {
                if (value != null) {
                  _cutBundleDateController.text = value.toIso8601String();
                }
              },
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: saveCutBundle,
              child: const Text('Save Cut Bundle'),
            ),
          ],
        ),
      ),
    );
  }
}