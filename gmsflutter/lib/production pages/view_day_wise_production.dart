import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gmsflutter/entity/production_part/day_wise_production.dart';
import 'package:gmsflutter/service/production_service/day_wise_production_service.dart';

class ViewDayWiseProduction extends StatefulWidget {
  const ViewDayWiseProduction({Key? key}) : super(key: key);

  @override
  State<ViewDayWiseProduction> createState() => _ViewDayWiseProductionState();
}

class _ViewDayWiseProductionState extends State<ViewDayWiseProduction> {
  late Future<List<DayWiseProduction>> _dayWiseProductionFuture;

  List<DayWiseProduction> _allProductions = [];
  List<DayWiseProduction> _filteredProductions = [];

  final TextEditingController _searchController = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    _dayWiseProductionFuture = DayWiseProductionService()
        .fetchDayWiseProduction();
    _dayWiseProductionFuture.then((data) {
      setState(() {
        _allProductions = data;
        _filteredProductions = data;
      });
    });

    _searchController.addListener(_applyFilters);
  }

  @override
  void dispose() {
    _searchController.removeListener(_applyFilters);
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final query = _searchController.text.trim();

    final filtered = _allProductions.where((prod) {
      final orderId = prod.order?.id?.toString() ?? '';
      final updatedDate = _parseDate(prod.updatedDate);

      final matchesSearch = query.isEmpty || orderId.contains(query);

      bool matchesDate = true;
      if (_fromDate != null &&
          (updatedDate == null || updatedDate.isBefore(_fromDate!))) {
        matchesDate = false;
      }
      if (_toDate != null &&
          (updatedDate == null || updatedDate.isAfter(_toDate!))) {
        matchesDate = false;
      }

      return matchesSearch && matchesDate;
    }).toList();

    setState(() {
      _filteredProductions = filtered;
    });
  }

  DateTime? _parseDate(String? dateStr) {
    try {
      return DateTime.parse(dateStr!).toLocal();
    } catch (e) {
      return null;
    }
  }

  Future<void> _pickFromDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
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
    final picked = await showDatePicker(
      context: context,
      initialDate: _toDate ?? DateTime.now(),
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
      _filteredProductions = List.from(_allProductions);
    });
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '-';
    try {
      final local = DateTime.parse(dateStr).toLocal();
      return DateFormat('dd-MMM-yyyy').format(local);
    } catch (e) {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: const Text(
          'Day Wise Production List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            tooltip: 'Clear Filters',
            onPressed: _clearFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Search by Order ID",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
            ),
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
                                  setState(() => _fromDate = null);
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
                                  setState(() => _toDate = null);
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
                          color: _toDate != null
                              ? Colors.black87
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<DayWiseProduction>>(
              future: _dayWiseProductionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (_filteredProductions.isEmpty) {
                  return const Center(
                    child: Text('No Day Wise Productions Found.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: _filteredProductions.length,
                    itemBuilder: (context, index) {
                      final order = _filteredProductions[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Order ID: ${order.order?.id ?? '-'}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow(
                                    "Production Order ID",
                                    order.productionOrder?.id?.toString() ??
                                        '-',
                                  ),
                                  _buildInfoRow(
                                    "Updated Date",
                                    _formatDate(order.updatedDate),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Short Size Qty",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            _buildInfoRow(
                                              "S",
                                              order.shortSQty.toString(),
                                            ),
                                            _buildInfoRow(
                                              "M",
                                              order.shortMQty.toString(),
                                            ),
                                            _buildInfoRow(
                                              "L",
                                              order.shortLQty.toString(),
                                            ),
                                            _buildInfoRow(
                                              "XL",
                                              order.shortXLQty.toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Full Size Qty",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            _buildInfoRow(
                                              "S",
                                              order.fullSQty.toString(),
                                            ),
                                            _buildInfoRow(
                                              "M",
                                              order.fullMQty.toString(),
                                            ),
                                            _buildInfoRow(
                                              "L",
                                              order.fullLQty.toString(),
                                            ),
                                            _buildInfoRow(
                                              "XL",
                                              order.fullXLQty.toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
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
