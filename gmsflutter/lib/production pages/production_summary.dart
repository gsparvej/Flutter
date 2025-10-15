import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_entities/production_summary.dart';
import 'package:gmsflutter/service/production_service/production_summary_service.dart';

class AllSummaryPage extends StatefulWidget {
  const AllSummaryPage({super.key});

  @override
  State<AllSummaryPage> createState() => _AllSummaryPageState();
}

class _AllSummaryPageState extends State<AllSummaryPage> {
  List<ProductionSummary> summaries = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAllSummaries();
  }

  Future<void> fetchAllSummaries() async {
    try {
      final service = ProductionSummaryService();
      // Send 0 or specific ID if your API expects it
      final data = await service.getAllProductionSummary(0);
      setState(() {
        summaries = data;
        loading = false;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Widget summaryCard(ProductionSummary summary, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order #${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Short S: ${summary.shortSTotal ?? 0}'),
            Text('Short M: ${summary.shortMTotal ?? 0}'),
            Text('Full L: ${summary.fullLTotal ?? 0}'),
            Text('Remaining Full XL: ${summary.remainingFullXLQty ?? 0}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Production Summaries")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: summaries.length,
        itemBuilder: (context, index) {
          return summaryCard(summaries[index], index);
        },
      ),
    );
  }
}
