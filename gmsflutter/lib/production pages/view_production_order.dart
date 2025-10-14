import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gmsflutter/entity/production_part/production_order.dart';
import 'package:gmsflutter/service/production_service/production_order_service.dart';

class ViewProductionOrder extends StatefulWidget {
  const ViewProductionOrder({Key? key}) : super(key: key);

  @override
  State<ViewProductionOrder> createState() => _ViewProductionOrderState();
}

class _ViewProductionOrderState extends State<ViewProductionOrder> {
  late Future<List<ProductionOrder>> _productionOrderFuture;

  List<ProductionOrder> _allOrders = [];
  List<ProductionOrder> _filteredOrders = [];

  final TextEditingController _searchController = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    _productionOrderFuture = ProductionOrderService().fetchProductionOrders();
    _productionOrderFuture.then((orders) {
      setState(() {
        _allOrders = orders;
        _filteredOrders = orders;
      });
    });

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _applyFilters();
  }

  void _applyFilters() {
    final query = _searchController.text.trim();

    final filtered = _allOrders.where((order) {
      final orderId = order.order?.id?.toString() ?? '';
      final startDate = _parseDate(order.startDate);

      final matchesSearch = query.isEmpty || orderId.contains(query);

      bool matchesDate = true;
      if (_fromDate != null && (startDate == null || startDate.isBefore(_fromDate!))) {
        matchesDate = false;
      }
      if (_toDate != null && (startDate == null || startDate.isAfter(_toDate!))) {
        matchesDate = false;
      }

      return matchesSearch && matchesDate;
    }).toList();

    setState(() {
      _filteredOrders = filtered;
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
    _searchController.clear();
    setState(() {
      _fromDate = null;
      _toDate = null;
      _filteredOrders = List.from(_allOrders);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: const Text('All Production Order List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            tooltip: 'Clear Filters',
            onPressed: _clearFilters,
          )
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickFromDate,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'From Date',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
          Expanded(
            child: FutureBuilder<List<ProductionOrder>>(
              future: _productionOrderFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (_filteredOrders.isEmpty) {
                  return const Center(child: Text('No Production Orders Found.'));
                } else {
                  return ListView.builder(
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                                  _buildInfoRow("Production Order ID", order.id.toString()),
                                  _buildInfoRow("Style Code", order.bomStyle?.styleCode ?? '-'),
                                  _buildInfoRow("Planned Qty", order.planQty.toString()),
                                  _buildInfoRow("Start Date", _formatDate(order.startDate)),
                                  _buildInfoRow("End Date", _formatDate(order.endDate)),
                                  _buildInfoRow("Size", order.size ?? '-'),
                                  _buildColoredRow("Priority", order.priority),
                                  _buildColoredRow("Status", order.status),
                                  _buildInfoRow("Description", order.description ?? '-'),
                                ],
                              ),
                            ),
                            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
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
    if (dateStr == null || dateStr.isEmpty) return '-';
    try {
      final localDate = DateTime.parse(dateStr).toLocal();
      return DateFormat('dd-MMM-yyyy').format(localDate);
    } catch (e) {
      return '-';
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

  Widget _buildColoredRow(String label, String? value) {
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
          _buildChip(value ?? '-', label == "Priority"),
        ],
      ),
    );
  }

  Widget _buildChip(String value, bool isPriority) {
    Color color;

    if (isPriority) {
      switch (value) {
        case 'Urgent':
          color = Colors.red;
          break;
        case 'Normal':
          color = Colors.orange;
          break;
        case 'Low':
          color = Colors.green;
          break;
        default:
          color = Colors.grey;
      }
    } else {
      switch (value) {
        case 'Planned':
          color = Colors.blueGrey;
          break;
        case 'Running':
          color = Colors.blue;
          break;
        case 'Completed':
          color = Colors.green;
          break;
        default:
          color = Colors.grey;
      }
    }

    return Chip(
      label: Text(value),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
