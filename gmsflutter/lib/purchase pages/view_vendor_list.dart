import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/purchase_part/vendor.dart';
import 'package:gmsflutter/purchase pages/vendor_details_by_id.dart';
import 'package:gmsflutter/service/purchase_service/vendor_service.dart';

// Styling constants for consistency
const Color _primaryColor = Colors.deepPurple;
const Color _accentColor = Colors.orange;

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

  // Helper to safely display string values
  String display(String? value) {
    if (value == null) return 'N/A';
    if (value.trim().isEmpty) return 'N/A';
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Vendor List'),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Vendor>>(
        future: vendorList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: _primaryColor));
          } else if (snapshot.hasError) {
            print('Vendor list error: ${snapshot.error}');
            return Center(child: Text('Error loading vendors: ${snapshot.error.toString().split(':')[0]}', style: const TextStyle(color: Colors.red)));
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
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: const CircleAvatar(
                      backgroundColor: _accentColor,
                      child: Icon(Icons.business, color: Colors.white),
                    ),
                    title: Text(
                      display(v.companyName),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: _primaryColor,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Contact Person: ${display(v.contactPerson)}"),
                        const SizedBox(height: 4),
                        Text("Phone: ${display(v.phone)}"),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                // Fetch the full vendor object by ID before navigating
                                Vendor ven = await VendorService().getVendorById(v.id!);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VendorDetailsPage(vendor: ven),
                                  ),
                                );
                              } catch (e) {
                                print('Error fetching vendor details: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Failed to load vendor details')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('View Details'),
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
}
