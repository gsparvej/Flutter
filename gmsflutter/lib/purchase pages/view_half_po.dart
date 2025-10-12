import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/purchase_order.dart';
import 'package:gmsflutter/purchase%20pages/view_full_po.dart';
import 'package:gmsflutter/service/purchase_service/purchase_order_service.dart';
import 'package:intl/intl.dart';

import 'view_full_requisition.dart';

class ViewHalfPO extends StatefulWidget {

  const ViewHalfPO({Key? key}) : super(key: key);

  @override
  State<ViewHalfPO> createState() => _ViewHalfPOState();
}

class _ViewHalfPOState extends State<ViewHalfPO> {
  late Future<List<PurchaseOrder>> purchaseOrderList;

  @override
  void initState() {
    super.initState();
    purchaseOrderList = PurchaseOrderService().fetchPOs();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All PO List')),
      body: FutureBuilder<List<PurchaseOrder>>(
        future: purchaseOrderList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Purchase Order List Available'));
          } else {
            final purchase = snapshot.data!;
            return ListView.builder(
              itemCount: purchase.length,
              itemBuilder: (context, index) {
                final po = purchase[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      "Delivery Date: ${formatLocalDate(po.deliveryDate)}",
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
                          "PO Date: ${formatLocalDate(po.poDate)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text("PO Number: ${display(po.poNumber)}"),
                        Text("Vendor Name: ${display(po.vendor?.companyName)}"),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () async {
                              PurchaseOrder pur = await PurchaseOrderService().getPOsById(po.id!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewFullPO(purchase: pur),
                                ),
                              );
                            },
                            child: const Text('View'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
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

  String display(String? value) {
    if (value == null) return 'N/A';
    if (value.trim().isEmpty) return 'N/A';
    return value;
  }

  String formatLocalDate(String? dateStr) {
    if (dateStr == null || dateStr.trim().isEmpty) return "N/A";
    try {
      final date = DateTime.parse(dateStr);
      final formatter = DateFormat.yMMMMd('en_US'); // Example: October 12, 2025
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

}
