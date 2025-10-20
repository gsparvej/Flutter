import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/order.dart';
import 'package:gmsflutter/merchandiser page/view_full_order.dart';
import 'package:gmsflutter/service/merchandiser_service/order_service.dart';
import 'package:intl/intl.dart';

// --- Color and Style Palette ---
class OrderPalette {
  static const Color primary = Color(0xFF1976D2); // Deep Blue - Professional
  static const Color accent = Color(0xFFFFC107); // Amber - Highlight/Warning
  static const Color cardBackground = Colors.white;
  static const Color primaryText = Color(0xFF263238);
  static const Color secondaryText = Color(0xFF757575);
  static const Color actionButton = Color(0xFF00ACC1); // Cyan/Teal - Clear Action
  static const Color deliveryDate = Color(0xFFD32F2F); // Red/Urgent
}

class ViewHalfOrder extends StatefulWidget {
  const ViewHalfOrder({Key? key}) : super(key: key);

  @override
  State<ViewHalfOrder> createState() => _ViewHalfOrderState();
}

class _ViewHalfOrderState extends State<ViewHalfOrder> {
  late Future<List<Order>> _orderListFuture;

  final TextEditingController _searchController = TextEditingController();
  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _orderListFuture = OrderService().fetchAllOrders();
    _orderListFuture.then((orders) {
      setState(() {
        _allOrders = orders;
        _filteredOrders = orders;
      });
    });
  }

  void _filterOrders(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      setState(() => _filteredOrders = _allOrders);
    } else {
      setState(() {
        _filteredOrders = _allOrders.where((order) {
          final id = order.id?.toString() ?? '';
          return id.contains(trimmed);
        }).toList();
      });
    }
  }

  void _viewFullOrder(BuildContext context, int? orderId) async {
    if (orderId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Order ID is missing.')),
      );
      return;
    }

    try {
      final fetchedOrder = await OrderService().getOrderById(orderId);
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewFullOrder(order: fetchedOrder),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load full order details: ${e.toString()}')),
      );
    }
  }

  String formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.trim().isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr).toLocal();
      final formatter = DateFormat('dd MMM yyyy').add_jm();
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

  Widget _buildDetailRow({required String label, required String value, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              color: OrderPalette.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor ?? OrderPalette.primaryText,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    final orderId = order.id?.toString() ?? 'N/A';
    final buyerName = order.buyer?.name ?? 'Unknown Buyer';
    final styleCode = order.bomStyle?.styleCode ?? 'N/A';
    final deliveryDate = formatLocalDate(order.deliveryDate);

    Color dateColor = OrderPalette.secondaryText;
    try {
      final date = DateTime.parse(order.deliveryDate!).toLocal();
      if (date.difference(DateTime.now()).inDays < 7) {
        dateColor = OrderPalette.deliveryDate;
      }
    } catch (_) {}

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: OrderPalette.primary.withOpacity(0.3), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: OrderPalette.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "ORDER #$orderId",
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Icon(Icons.shopping_cart_checkout, color: OrderPalette.primary, size: 24),
              ],
            ),
            const Divider(height: 20, thickness: 1.5),
            _buildDetailRow(label: 'Buyer Org', value: buyerName),
            _buildDetailRow(label: 'Style Code', value: styleCode),
            _buildDetailRow(label: 'Delivery Date', value: deliveryDate, valueColor: dateColor),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: order.id == null ? null : () => _viewFullOrder(context, order.id),
                icon: const Icon(Icons.visibility, size: 20),
                label: const Text(
                  'VIEW FULL ORDER',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: OrderPalette.actionButton,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrderPalette.cardBackground.withOpacity(0.95),
      appBar: AppBar(
        title: const Text(
          'Pending Orders',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: OrderPalette.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Add Order Form')),
              );
            },
            tooltip: 'Create New Order',
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by Order ID...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _filterOrders,
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Order>>(
              future: _orderListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: OrderPalette.primary),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: OrderPalette.deliveryDate, size: 50),
                          const SizedBox(height: 10),
                          Text(
                            "Failed to load orders. Check service connection.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: OrderPalette.deliveryDate, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  if (_filteredOrders.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined, color: OrderPalette.secondaryText, size: 50),
                          SizedBox(height: 10),
                          Text('No orders matching your search.', style: TextStyle(fontSize: 18, color: OrderPalette.secondaryText)),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      return _buildOrderCard(context, _filteredOrders[index]);
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
}
