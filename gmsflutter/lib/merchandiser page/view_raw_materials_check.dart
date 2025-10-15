import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/raw_materials_check.dart';
import 'package:gmsflutter/service/merchandiser_service/raw_materials_check_service.dart';

class ViewRawMaterialsCheck extends StatefulWidget {
  const ViewRawMaterialsCheck({Key? key}) : super(key: key);

  @override
  State<ViewRawMaterialsCheck> createState() => _ViewRawMaterialsCheckState();
}

class _ViewRawMaterialsCheckState extends State<ViewRawMaterialsCheck> {
  late Future<List<RawMaterialsCheck>> rawMaterialsCheckList;

  @override
  void initState() {
    super.initState();
    rawMaterialsCheckList = RawMaterialsCheckService().fetchRawMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raw Materials by Buyer Orders'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<RawMaterialsCheck>>(
        future: rawMaterialsCheckList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Raw Materials Check List Available'));
          } else {
            final rawList = snapshot.data!;
            return ListView.builder(
              itemCount: rawList.length,
              itemBuilder: (context, index) {
                final materials = rawList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Raw Materials ID: ${materials.id}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Order ID: ${materials.order?.id ?? 'N/A'}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Divider(height: 20, color: Colors.grey),

                        const Text(
                          "Short Sleeve Sizes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        buildSizeRow("S", materials.shortSTotalQuantity),
                        buildSizeRow("M", materials.shortMTotalQuantity),
                        buildSizeRow("L", materials.shortLTotalQuantity),
                        buildSizeRow("XL", materials.shortXLTotalQuantity),

                        const SizedBox(height: 10),
                        const Text(
                          "Full Sleeve Sizes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        buildSizeRow("S", materials.fullSTotalQuantity),
                        buildSizeRow("M", materials.fullMTotalQuantity),
                        buildSizeRow("L", materials.fullLTotalQuantity),
                        buildSizeRow("XL", materials.fullXLTotalQuantity),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              "Total Fabric Needed: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${materials.totalFabric ?? 'N/A'}"),
                          ],
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

  Widget buildSizeRow(String size, int? qty) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text("$size Size Total Qty:"),
          ),
          Expanded(
            flex: 2,
            child: Text("${qty ?? 'N/A'}"),
          ),
        ],
      ),
    );
  }
}
