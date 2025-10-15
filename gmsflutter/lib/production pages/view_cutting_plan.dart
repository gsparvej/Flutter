import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_entities/cutting_plan.dart';
import 'package:gmsflutter/service/production_service/cutting_plan_service.dart';
import 'package:intl/intl.dart';


class ViewCuttingPlan extends StatefulWidget {
  const ViewCuttingPlan({Key? key}) : super(key: key);

  @override
  State<ViewCuttingPlan> createState() => _ViewCuttingPlanState();
}

class _ViewCuttingPlanState extends State<ViewCuttingPlan> {
  late Future<List<CuttingPlan>> cuttingPlanFuture;
  List<CuttingPlan> _allPlans = [];
  List<CuttingPlan> _filteredPlans = [];

  final TextEditingController _prodOrderController = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    cuttingPlanFuture = CuttingPlanService().fetchCuttingPlan();
    cuttingPlanFuture.then((plans) {
      setState(() {
        _allPlans = plans;
        _filteredPlans = plans;
      });
    });
    _prodOrderController.addListener(_onFilterChanged);
  }

  @override
  void dispose() {
    _prodOrderController.removeListener(_onFilterChanged);
    _prodOrderController.dispose();
    super.dispose();
  }

  void _onFilterChanged() {
    _applyFilters();
  }

  void _applyFilters() {
    final query = _prodOrderController.text.trim();

    List<CuttingPlan> filtered = _allPlans.where((plan) {
      // Filter by Production Order ID if provided
      final prodOrderStr = plan.productionOrderId.toString();
      bool matchesProdOrder = query.isEmpty || prodOrderStr.contains(query);

      // Filter by date range if set
      bool matchesDate = true;
      if (_fromDate != null) {
        final planDate = _parseDate(plan.cuttingDate);
        if (planDate == null || planDate.isBefore(_fromDate!)) {
          matchesDate = false;
        }
      }
      if (_toDate != null) {
        final planDate = _parseDate(plan.cuttingDate);
        if (planDate == null || planDate.isAfter(_toDate!)) {
          matchesDate = false;
        }
      }

      return matchesProdOrder && matchesDate;
    }).toList();

    setState(() {
      _filteredPlans = filtered;
    });
  }

  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr).toLocal();
    } catch (e) {
      return null;
    }
  }

  Future<void> _pickFromDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? now,
      firstDate: DateTime(2000),
      lastDate: _toDate ?? DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fromDate = picked;
      });
      _applyFilters();
    }
  }

  Future<void> _pickToDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _toDate ?? now,
      firstDate: _fromDate ?? DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _toDate = picked;
      });
      _applyFilters();
    }
  }

  void _clearFilters() {
    _prodOrderController.clear();
    setState(() {
      _fromDate = null;
      _toDate = null;
      _filteredPlans = List.from(_allPlans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: const Text(
          "Cutting Plans",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: "Clear Filters",
            onPressed: _clearFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search field for Production Order ID
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _prodOrderController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Search by Production Order ID",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: _prodOrderController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _prodOrderController.clear();
                  },
                )
                    : null,
              ),
            ),
          ),
          // Date pickers: From / To
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickFromDate,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'From Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: _fromDate != null
                            ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _fromDate = null;
                            });
                            _applyFilters();
                          },
                        )
                            : null,
                      ),
                      child: Text(
                        _fromDate != null
                            ? DateFormat('dd-MMM-yyyy').format(_fromDate!)
                            : 'Select From Date',
                        style: TextStyle(
                          color: _fromDate != null ? Colors.black87 : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: _pickToDate,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'To Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: _toDate != null
                            ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _toDate = null;
                            });
                            _applyFilters();
                          },
                        )
                            : null,
                      ),
                      child: Text(
                        _toDate != null
                            ? DateFormat('dd-MMM-yyyy').format(_toDate!)
                            : 'Select To Date',
                        style: TextStyle(
                          color: _toDate != null ? Colors.black87 : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // The list of plans
          Expanded(
            child: FutureBuilder<List<CuttingPlan>>(
              future: cuttingPlanFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (_filteredPlans.isEmpty) {
                  return const Center(child: Text("No Cutting Plans found."));
                } else {
                  return ListView.builder(
                    itemCount: _filteredPlans.length,
                    itemBuilder: (context, index) {
                      final plan = _filteredPlans[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              plan.id != null ? "Plan #${plan.id}" : "Plan",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow("Marker No", plan.markerNo ?? ""),
                                _buildInfoRow("Production Order ID", plan.productionOrderId.toString()),
                                _buildInfoRow("Cutting Date", _formatDate(plan.cuttingDate)),
                                _buildInfoRow("Planned Pcs", plan.plannedPcs?.toStringAsFixed(0) ?? ""),
                                _buildInfoRow("Fabric Width", plan.fabricWidth?.toStringAsFixed(2) ?? ""),
                                _buildInfoRow("Status", plan.status ?? ""),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      final dt = DateTime.parse(dateStr).toLocal();
      return DateFormat('dd‑MMM‑yyyy').format(dt);
    } catch (e) {
      return "";
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}