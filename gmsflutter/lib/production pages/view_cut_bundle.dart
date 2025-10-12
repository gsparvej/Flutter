import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_part/cut_bundle.dart';
import 'package:gmsflutter/service/production_service/cut_bundle_service.dart';
import 'package:intl/intl.dart';


class ViewCutBundle extends StatefulWidget {
  const ViewCutBundle({Key? key}) : super(key: key);

  @override
  State<ViewCutBundle> createState() => _ViewCutBundleState();
}

class _ViewCutBundleState extends State<ViewCutBundle> {
  late Future<List<CutBundle>> cutBundleListFuture;
  List<CutBundle> _allBundles = [];
  List<CutBundle> _filteredBundles = [];

  final TextEditingController _searchController = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    cutBundleListFuture = CutBundleService().fetchCutBundle();
    cutBundleListFuture.then((bundles) {
      setState(() {
        _allBundles = bundles;
        _filteredBundles = bundles;
      });
    });

    _searchController.addListener(_onFilterChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onFilterChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onFilterChanged() {
    _applyFilters();
  }

  void _applyFilters() {
    final query = _searchController.text.trim();

    List<CutBundle> filtered = _allBundles.where((bundle) {
      // Filter by Cutting Plan ID if provided
      final planIdStr = bundle.cuttingPlanId.toString();
      final matchesId = query.isEmpty || planIdStr.contains(query);

      // Filter by date range if both dates are selected
      bool matchesDate = true;
      if (_fromDate != null) {
        final bundleDate = _parseDate(bundle.cutBundleDate);
        if (bundleDate == null || bundleDate.isBefore(_fromDate!)) {
          matchesDate = false;
        }
      }
      if (_toDate != null) {
        final bundleDate = _parseDate(bundle.cutBundleDate);
        if (bundleDate == null || bundleDate.isAfter(_toDate!)) {
          matchesDate = false;
        }
      }

      return matchesId && matchesDate;
    }).toList();

    setState(() {
      _filteredBundles = filtered;
    });
  }

  DateTime? _parseDate(String dateStr) {
    try {
      return DateTime.parse(dateStr).toLocal();
    } catch (e) {
      return null;
    }
  }

  Future<void> _pickFromDate() async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
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
    final DateTime? picked = await showDatePicker(
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
    _searchController.clear();
    setState(() {
      _fromDate = null;
      _toDate = null;
      _filteredBundles = List.from(_allBundles);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: const Text(
          "All Cut Bundle List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: "Clear Filters",
            onPressed: _clearFilters,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Search by Cutting Plan ID",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
                    : null,
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                          color: _fromDate != null
                              ? Colors.black87
                              : Colors.grey[600],
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
                          color:
                          _toDate != null ? Colors.black87 : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CutBundle>>(
              future: cutBundleListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (_filteredBundles.isEmpty) {
                  return const Center(child: Text("No Cut Bundle found."));
                } else {
                  return ListView.builder(
                    itemCount: _filteredBundles.length,
                    itemBuilder: (context, index) {
                      final cutBundle = _filteredBundles[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              cutBundle.bundleNo,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow("Bundle No", cutBundle.bundleNo),
                                  _buildInfoRow("Color", cutBundle.color),
                                  _buildInfoRow(
                                      "Cut Date",
                                      _formatLocalDate(
                                          cutBundle.cutBundleDate)),
                                  _buildInfoRow("Quantity",
                                      cutBundle.plannedQty.toString()),
                                  _buildInfoRow("Size", cutBundle.size),
                                  _buildInfoRow("Cutting Plan ID",
                                      cutBundle.cuttingPlanId.toString()),
                                ],
                              ),
                            ),
                            trailing: const Icon(Icons.chevron_right,
                                color: Colors.grey, size: 24),
                            onTap: () {
                              // Add navigation or details here if needed
                            },
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

  // Format UTC string to local readable date
  String _formatLocalDate(String dateStr) {
    try {
      final utcDate = DateTime.parse(dateStr);
      final localDate = utcDate.toLocal();
      return DateFormat('dd-MMM-yyyy').format(localDate);
    } catch (e) {
      return "Invalid date";
    }
  }

  // Label-value row widget
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