import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_entities/machine.dart';
import 'package:gmsflutter/service/production_service/machine_service.dart';

class MachinePage extends StatefulWidget {
  const MachinePage({Key? key}) : super(key: key);

  @override
  State<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _machineCodeController = TextEditingController();

  final MachineService _machineService = MachineService();

  List<Machine> _machines = [];
  bool _isLoading = false;

  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _fetchMachines();
  }

  Future<void> _fetchMachines() async {
    setState(() => _isLoading = true);
    try {
      final machines = await _machineService.fetchMachine();
      setState(() => _machines = machines);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading machines: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveMachine() async {
    if (!_formKey.currentState!.validate()) return;

    final machine = Machine(
      machineCode: _machineCodeController.text,
      status: _selectedStatus,
    );

    bool success = await _machineService.addMachine(machine);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Machine saved successfully')),
      );
      _machineCodeController.clear();
      setState(() {
        _selectedStatus = null;
      });
      _fetchMachines(); // Refresh list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save machine')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Machine Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form to add machine
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _machineCodeController,
                    decoration: const InputDecoration(labelText: 'Machine Code'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter machine code' : null,
                  ),
                  const SizedBox(height: 12),

                  // Dropdown for status
                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: const [
                      DropdownMenuItem(value: '', child: Text('-- Select Status --')),
                      DropdownMenuItem(value: 'ACTIVE', child: Text('ACTIVE')),
                      DropdownMenuItem(value: 'INACTIVE', child: Text('INACTIVE')),
                      DropdownMenuItem(value: 'REPAIR', child: Text('REPAIR')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    },
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please select a status' : null,
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _saveMachine,
                    child: const Text('Save Machine'),
                  ),
                ],
              ),
            ),

            const Divider(height: 40),

            // Machine list
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
              child: _machines.isEmpty
                  ? const Text('No machines found.')
                  : ListView.builder(
                itemCount: _machines.length,
                itemBuilder: (context, index) {
                  final machine = _machines[index];
                  return ListTile(
                    title: Text(machine.machineCode ?? ''),
                    subtitle: Text('Status: ${machine.status ?? 'Unknown'}'),
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
