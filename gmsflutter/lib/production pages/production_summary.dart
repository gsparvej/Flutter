import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/production_entities/production_summary.dart';
import 'package:gmsflutter/service/production_service/production_summary_service.dart';

// --- Theme Constants ---
const Color kPrimaryColor = Colors.indigo;
const Color kAccentColor = Colors.deepOrange;
const BorderRadius kBorderRadius = BorderRadius.all(Radius.circular(12));

class ProductionSummaryPage extends StatefulWidget {
  final List<int> orderIds;

  const ProductionSummaryPage({super.key, required this.orderIds});

  @override
  State<ProductionSummaryPage> createState() => _ProductionSummaryPageState();
}

class _ProductionSummaryPageState extends State<ProductionSummaryPage> {
  final ProductionSummaryService service = ProductionSummaryService();
  final TextEditingController searchController = TextEditingController();

  List<ProductionSummary> allSummaries = [];
  List<ProductionSummary> filteredSummaries = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadSummaries();
    searchController.addListener(filterByOrderId); // ✅ search fix
  }

  @override
  void dispose() {
    searchController.removeListener(filterByOrderId);
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadSummaries() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final summaries = await service.getAllSummaries(widget.orderIds);
      setState(() {
        allSummaries = summaries;
        filteredSummaries = List.from(allSummaries);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = "Failed to load summaries. Please try again.";
        isLoading = false;
      });
    }
  }

  void filterByOrderId() {
    String searchText = searchController.text.trim();

    setState(() {
      if (searchText.isEmpty) {
        filteredSummaries = List.from(allSummaries);
      } else {
        filteredSummaries = allSummaries
            .where((summary) =>
        summary.orderId != null &&
            summary.orderId.toString().contains(searchText))
            .toList();
      }
    });
  }

  Widget _buildStatRow(String label, dynamic value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
          Text(value?.toString() ?? "0",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: valueColor ?? kPrimaryColor)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 8.0, bottom: 4.0),
      child: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.w800, fontSize: 16, color: kPrimaryColor)),
    );
  }

  Widget _buildSummaryCard(ProductionSummary summary) {
    int totalRemaining = (summary.remainingShortSQty ?? 0) +
        (summary.remainingShortMQty ?? 0) +
        (summary.remainingShortLQty ?? 0) +
        (summary.remainingShortXLQty ?? 0) +
        (summary.remainingFullSQty ?? 0) +
        (summary.remainingFullMQty ?? 0) +
        (summary.remainingFullLQty ?? 0) +
        (summary.remainingFullXLQty ?? 0);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: kBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: kBorderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              color: kPrimaryColor.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order ID: ${summary.orderId}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kPrimaryColor)),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: totalRemaining > 0 ? kAccentColor : Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      totalRemaining > 0
                          ? "Remaining: $totalRemaining"
                          : "Completed",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Short Sleeve Production"),
                  _buildStatRow("Size S", summary.shortSTotal),
                  _buildStatRow("Size M", summary.shortMTotal),
                  _buildStatRow("Size L", summary.shortLTotal),
                  _buildStatRow("Size XL", summary.shortXLTotal),
                  _buildSectionHeader("Full Sleeve Production"),
                  _buildStatRow("Size S", summary.fullSTotal),
                  _buildStatRow("Size M", summary.fullMTotal),
                  _buildStatRow("Size L", summary.fullLTotal),
                  _buildStatRow("Size XL", summary.fullXLTotal),
                  const Divider(height: 20),

                  // Remaining Quantities in 2 columns
                  _buildSectionHeader("Remaining Quantities"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStatRow("Short S", summary.remainingShortSQty,
                                valueColor: kAccentColor),
                            _buildStatRow("Short M", summary.remainingShortMQty,
                                valueColor: kAccentColor),
                            _buildStatRow("Short L", summary.remainingShortLQty,
                                valueColor: kAccentColor),
                            _buildStatRow("Short XL", summary.remainingShortXLQty,
                                valueColor: kAccentColor),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStatRow("Full S", summary.remainingFullSQty,
                                valueColor: kAccentColor),
                            _buildStatRow("Full M", summary.remainingFullMQty,
                                valueColor: kAccentColor),
                            _buildStatRow("Full L", summary.remainingFullLQty,
                                valueColor: kAccentColor),
                            _buildStatRow("Full XL", summary.remainingFullXLQty,
                                valueColor: kAccentColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
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
      appBar: AppBar(
        title: const Text("Production Summaries",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Search by Order ID",
                hintText: "Enter ID to filter...",
                prefixIcon: const Icon(Icons.search, color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: isLoading
                  ? const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor))
                  : error != null
                  ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "🛑 $error",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ))
                  : filteredSummaries.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox_outlined,
                        size: 60, color: Colors.grey[300]),
                    const SizedBox(height: 10),
                    const Text(
                      "No summaries match your filter.",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: filteredSummaries.length,
                itemBuilder: (context, index) =>
                    _buildSummaryCard(filteredSummaries[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
