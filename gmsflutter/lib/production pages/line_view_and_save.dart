import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_entities/line.dart';
import 'package:gmsflutter/service/production_service/line_service.dart';

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

  // List of lines
  List<Line> _lines = [];

  // Loading flag
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchLines();
  }

  Future<void> _fetchLines() async {
    setState(() => _isLoading = true);
    try {
      List<Line> lines = await _lineService.fetchLine();
      setState(() => _lines = lines);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading lines: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveLine() async {
    if (!_formKey.currentState!.validate()) return;

    Line newLine = Line(
      lineCode: _lineCodeController.text,
      floor: _floorController.text,
      capacityPerHour: int.tryParse(_capacityController.text),
    );

    bool success = await _lineService.addLine(newLine);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Line saved successfully')),
      );
      _lineCodeController.clear();
      _floorController.clear();
      _capacityController.clear();
      _fetchLines(); // Refresh the list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save line')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Line Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form to Add Line
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _lineCodeController,
                    decoration: const InputDecoration(labelText: 'Line Code'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter line code' : null,
                  ),
                  TextFormField(
                    controller: _floorController,
                    decoration: const InputDecoration(labelText: 'Floor'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter floor' : null,
                  ),
                  TextFormField(
                    controller: _capacityController,
                    decoration: const InputDecoration(labelText: 'Capacity Per Hour'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Enter capacity';
                      if (int.tryParse(value) == null) return 'Must be a number';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _saveLine,
                    child: const Text('Save Line'),
                  ),
                ],
              ),
            ),
            const Divider(height: 40),

            // Line List
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
              child: _lines.isEmpty
                  ? const Text('No lines found.')
                  : ListView.builder(
                itemCount: _lines.length,
                itemBuilder: (context, index) {
                  Line line = _lines[index];
                  return ListTile(
                    title: Text(line.lineCode ?? ''),
                    subtitle: Text('Floor: ${line.floor}, Capacity: ${line.capacityPerHour}'),
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
