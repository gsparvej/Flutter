import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/buyer.dart';
import 'package:gmsflutter/service/merchandiser_service/buyer_service.dart';


class ViewBuyer extends StatefulWidget {
  const ViewBuyer({Key? key}) : super(key: key);

  @override
  State<ViewBuyer> createState() => _BuyerDetailsState();
}

class _BuyerDetailsState extends State<ViewBuyer> {
  late Future<List<Buyer>> buyerList;

  @override
  void initState() {
    super.initState();
    buyerList = BuyerService().fetchBuyers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Buyer List")),
      body: FutureBuilder<List<Buyer>>(
        future: buyerList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No buyers found."));
          } else {
            final buyers = snapshot.data!;
            return ListView.builder(
              itemCount: buyers.length,
              itemBuilder: (context, index) {
                final buyer = buyers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      buyer.name ?? "Unknown Buyer",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (buyer.contactPerson != null)
                          Text("Contact Person: ${buyer.contactPerson}"),
                        if (buyer.phone != null)
                          Text("Phone: ${buyer.phone}"),
                        if (buyer.email != null)
                          Text("Email: ${buyer.email}"),
                        if (buyer.country != null)
                          Text("Country: ${buyer.country}"),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}