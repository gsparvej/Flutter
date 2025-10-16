import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/merchandiser_part/bom_style.dart';
import 'package:gmsflutter/merchandiser%20page/view_bom.dart';
import 'package:gmsflutter/service/merchandiser_service/bom_style_service.dart';

class ViewBomStyle extends StatefulWidget {
  const ViewBomStyle({Key? key}) : super(key: key);

  @override
  State<ViewBomStyle> createState() => _ViewBomStyleState();
}

class _ViewBomStyleState extends State<ViewBomStyle> {
  late Future<List<BomStyle>> bomStyleList;

  @override
  void initState() {
    super.initState();
    bomStyleList = BomStyleService().fetchAllBomStyles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All BOM List')),
      body: FutureBuilder<List<BomStyle>>(
        future: bomStyleList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No BOM List Available'));
          } else {
            final bomStyle = snapshot.data!;
            return ListView.builder(
              itemCount: bomStyle.length,
              itemBuilder: (context, index) {
                final bom = bomStyle[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      "Style Code: ${bom.styleCode}",
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
                          "Style Type: ${bom.styleType ?? 'N/A'}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text("Description: ${bom.description ?? 'N/A'}"),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                final fetchedBoms = await BomStyleService()
                                    .getBOMByStyleCode(bom.styleCode!);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewBomsByStyleCode(
                                      styleCode: bom.styleCode!,
                                      allBoms: fetchedBoms,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
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
}
