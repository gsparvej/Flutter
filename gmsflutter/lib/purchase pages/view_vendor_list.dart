import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/vendor.dart';
import 'package:gmsflutter/purchase%20pages/vendor_details_by_id.dart';
import 'package:gmsflutter/service/purchase_service/vendor_service.dart';

class ViewVendorList extends StatefulWidget {
  const ViewVendorList({Key? key}) : super(key: key);

  @override
  State<ViewVendorList> createState() => _ViewVendorListState();
}

class _ViewVendorListState extends State<ViewVendorList> {
  late Future<List<Vendor>> vendorList;

  @override
  void initState() {
    super.initState();
    vendorList = VendorService().fetchVendor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Vendor List')),
      body: FutureBuilder<List<Vendor>>(
        future: vendorList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Vendor List Available'));
          } else {
            final vendors = snapshot.data!;
            return ListView.builder(
              itemCount: vendors.length,
              itemBuilder: (context, index) {
                final v = vendors[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      "Company Name: ${display(v.companyName)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Contact Person: ${display(v.contactPerson)}"),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VendorDetailsPage(vendor: v),
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
}
