import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_entities/machine.dart';
import 'package:gmsflutter/service/production_service/machine_service.dart';

// Styling constants for consistency (Mirrors LinePage)
const Color _primaryColor = Colors.deepPurple;
const Color _accentColor = Colors.orangeAccent;
const Color _successColor = Colors.green;
const Color _errorColor = Colors.red;

class MachinePage extends StatefulWidget {
  const MachinePage({Key? key}) : super(key: key);

  @override
  State<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _machineCodeController = TextEditingController();

  // Service
  final MachineService _machineService = MachineService();

  // State
  List<Machine> _machines = [];
  bool _isLoading = false;
  String? _selectedStatus; // Null by default

  // List of available statuses
  static const List<String> _statuses = ['ACTIVE', 'INACTIVE', 'REPAIR'];

  @override
  void initState() {
    super.initState();
    _fetchMachines();
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    _machineCodeController.dispose();
    super.dispose();
  }

  Future<void> _fetchMachines() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }
    try {
      final machines = await _machineService.fetchMachine();
      if (mounted) {
        setState(() => _machines = machines);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading machines: $e'), backgroundColor: _errorColor),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveMachine() async {
    if (!_formKey.currentState!.validate()) return;

    final machine = Machine(
      machineCode: _machineCodeController.text.trim(),
      status: _selectedStatus,
    );

    bool success = await _machineService.addMachine(machine);

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Machine saved successfully'), backgroundColor: _successColor),
        );
      }
      _machineCodeController.clear();
      if (mounted) {
        setState(() {
          _selectedStatus = null; // Clear selected status
        });
      }
      _fetchMachines(); // Refresh list
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save machine'), backgroundColor: _errorColor),
        );
      }
    }
  }

  // Helper function for consistent InputDecoration styling
  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: _primaryColor, width: 2),
      ),
    );
  }

  // Helper to determine status color
  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return _successColor;
      case 'REPAIR':
        return _accentColor;
      case 'INACTIVE':
        return _errorColor;
      default:
        return Colors.grey;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Management'),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Form to Add Machine (Wrapped in Card for style) ---
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
                        'Add New Production Machine',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _primaryColor),
                      ),
                      const SizedBox(height: 15),

                      // Machine Code Field
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          controller: _machineCodeController,
                          decoration: _buildInputDecoration('Machine Code (e.g., M-CNC-01)'),
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter the machine code' : null,
                        ),
                      ),

                      // Status Dropdown
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          decoration: _buildInputDecoration('Status'),
                          items: _statuses.map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedStatus = value;
                            });
                          },
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please select a status' : null,
                        ),
                      ),

                      // Save Button
                      ElevatedButton(
                        onPressed: _saveMachine,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 3,
                        ),
                        child: const Text('Save Machine', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Divider(height: 40, thickness: 1),

            // --- Machine List Header ---
            const Text(
              'Existing Production Machines',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),

            // --- Machine List ---
            _isLoading
                ? const Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(color: _primaryColor),
            )
                : Expanded(
              child: _machines.isEmpty
                  ? const Center(child: Text('No machines found. Add one above.'))
                  : ListView.builder(
                itemCount: _machines.length,
                itemBuilder: (context, index) {
                  final machine = _machines[index];
                  final statusText = machine.status ?? 'Unknown';
                  final statusColor = _getStatusColor(statusText);

                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(Icons.miscellaneous_services, color: statusColor),
                      title: Text(machine.machineCode ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.w600)),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: statusColor, width: 1),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
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
