import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/order.dart';
import 'package:gmsflutter/merchandiser%20page/view_full_order.dart';
import 'package:gmsflutter/service/merchandiser_service/order_service.dart';
import 'package:intl/intl.dart';

class ViewHalfOrder extends StatefulWidget {
  const ViewHalfOrder({Key? key}) : super(key: key);

  @override
  State<ViewHalfOrder> createState() => _ViewHalfOrderState();
}

class _ViewHalfOrderState extends State<ViewHalfOrder> {
  late Future<List<Order>> orderList;

  @override
  void initState() {
    super.initState();
    orderList = OrderService().fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Order List')),
      body: FutureBuilder<List<Order>>(
        future: orderList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Order List Available'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      "Order ID: ${order.id}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          "Buyer Organization: ${order.buyer?.name ?? 'N/A'}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text("Style Code: ${order.bomStyle?.styleCode ?? 'N/A'}"),
                        Text("Delivery Date: ${formatLocalDate(order.deliveryDate)}"),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () async {
                              final fetchedOrder = await OrderService().getOrderById(order.id!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewFullOrder(order: fetchedOrder),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            child: const Text('View'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.trim().isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr).toLocal();
      final formatter = DateFormat('dd-MMM-yyyy'); // Example: 15-Oct-2025
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }
}
