import 'dart:convert';
import 'package:gmsflutter/entity/production_entities/production_summary.dart';
import 'package:http/http.dart' as http;

class ProductionSummaryService {
  final String baseUrl = "http://localhost:8080/api/proSummaryorder";

  /// Fetch single summary by orderId
  Future<ProductionSummary?> getSummaryByOrderId(int orderId) async {
    final url = Uri.parse("$baseUrl/production-summaryAll?orderId=$orderId");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProductionSummary.fromJson({...data, 'orderId': orderId});
    } else {
      print("Error ${response.statusCode}: ${response.body}");
      return null;
    }
  }

  /// Fetch summaries for multiple orderIds
  Future<List<ProductionSummary>> getAllSummaries(List<int> orderIds) async {
    List<ProductionSummary> summaries = [];
    for (int id in orderIds) {
      final summary = await getSummaryByOrderId(id);
      if (summary != null) summaries.add(summary);
    }
    return summaries;
  }
}
