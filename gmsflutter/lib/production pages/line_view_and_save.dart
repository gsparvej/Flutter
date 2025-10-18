import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_entities/line.dart';
import 'package:gmsflutter/service/production_service/line_service.dart';

// Styling constants for consistency
const Color _primaryColor = Colors.deepPurple;
const Color _accentColor = Colors.orangeAccent;
const Color _successColor = Colors.green;
const Color _errorColor = Colors.red;

class LinePage extends StatefulWidget {
  const LinePage({Key? key}) : super(key: key);

  @override
  State<LinePage> createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _lineCodeController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  // Service
  final LineService _lineService = LineService();

  // State
  List<Line> _lines = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchLines();
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    _lineCodeController.dispose();
    _floorController.dispose();
    _capacityController.dispose();
    super.dispose();
  }


  Future<void> _fetchLines() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }
    try {
      List<Line> lines = await _lineService.fetchLine();
      if (mounted) {
        setState(() => _lines = lines);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading lines: $e'), backgroundColor: _errorColor),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveLine() async {
    if (!_formKey.currentState!.validate()) return;

    Line newLine = Line(
      lineCode: _lineCodeController.text.trim(),
      floor: _floorController.text.trim(),
      capacityPerHour: int.tryParse(_capacityController.text.trim()),
    );

    bool success = await _lineService.addLine(newLine);

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Line saved successfully'), backgroundColor: _successColor),
        );
      }
      _lineCodeController.clear();
      _floorController.clear();
      _capacityController.clear();
      _fetchLines(); // Refresh the list
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save line'), backgroundColor: _errorColor),
        );
      }
    }
  }

  // Helper function for consistent TextFormField styling
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: _primaryColor, width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Management'),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Form to Add Line ---
            Form(
              key: _formKey,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Add New Production Line',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _primaryColor),
                      ),
                      const SizedBox(height: 15),

                      _buildTextFormField(
                        controller: _lineCodeController,
                        labelText: 'Line Code (e.g., L-001)',
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter a line code' : null,
                      ),
                      _buildTextFormField(
                        controller: _floorController,
                        labelText: 'Floor (e.g., Ground Floor)',
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter the floor' : null,
                      ),
                      _buildTextFormField(
                        controller: _capacityController,
                        labelText: 'Capacity Per Hour (Units)',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter capacity';
                          if (int.tryParse(value.trim()) == null) return 'Capacity must be a number';
                          return null;
                        },
                      ),

                      ElevatedButton(
                        onPressed: _saveLine,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 3,
                        ),
                        child: const Text('Save Line', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Divider(height: 40, thickness: 1),

            // --- Line List Header ---
            const Text(
              'Existing Production Lines',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),

            // --- Line List ---
            _isLoading
                ? const Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(color: _primaryColor),
            )
                : Expanded(
              child: _lines.isEmpty
                  ? const Center(child: Text('No production lines found. Add one above.'))
                  : ListView.builder(
                itemCount: _lines.length,
                itemBuilder: (context, index) {
                  Line line = _lines[index];
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.precision_manufacturing, color: _primaryColor),
                      title: Text(line.lineCode ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Floor: ${line.floor ?? 'N/A'}'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${line.capacityPerHour ?? 0} units/hr',
                          style: const TextStyle(color: _accentColor, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
