import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/uom.dart';
import 'package:gmsflutter/service/merchandiser_service/uom_service.dart';

class ViewUom extends StatefulWidget {
  const ViewUom({Key? key}) : super(key: key);

  @override
  State<ViewUom> createState() => _ViewUomState();
}

class _ViewUomState extends State<ViewUom> {
  late Future<List<Uom>> uomList;

  @override
  void initState() {
    super.initState();
    uomList = UomService().fetchUom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All UOM List')),
      body: FutureBuilder<List<Uom>>(
        future: uomList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('No UOM List Availabe'));
          } else {
            final uoms = snapshot.data!;
            return ListView.builder(
              itemCount: uoms.length,
              itemBuilder: (context, index) {
                final u = uoms[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      ("Size: ${u.size}"),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (u.productName != null)
                          Text("Product Name: ${u.productName}"),
                        if(u.body != null)
                          Text("Body's Fabric: ${u.body}"),
                        if(u.sleeve != null)
                          Text("Sleeve: ${u.sleeve}"),
                        if(u.pocket != null)
                          Text("Body's Fabric: ${u.pocket}"),
                        if(u.wastage != null)
                          Text("Sleeve: ${u.wastage}"),
                        if(u.shrinkage != null)
                          Text("Sleeve: ${u.shrinkage}"),
                        if(u.baseFabric != null)
                          Text("Body's Fabric: ${u.baseFabric}")
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
