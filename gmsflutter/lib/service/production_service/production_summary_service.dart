import 'dart:convert';
import 'package:gmsflutter/entity/production_entities/production_summary.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ProductionSummaryService {

  final String baseUrl = 'http://localhost:8080/api/proSummaryorder';


  Future<List<ProductionSummary>> getAllProductionSummary(int orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final uri = Uri.parse('$baseUrl/production-summaryAll')
        .replace(queryParameters: {'orderId': orderId.toString()});

    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Assuming API returns List<ProductionSummary>
      final List<dynamic> summariesJson = data['summaryList'] ?? data;
      return summariesJson
          .map((json) => ProductionSummary.fromJson(json))
          .toList();
    } else {
      print('Error fetching all summaries: ${response.statusCode}');
      throw Exception('Failed to load summaries');
    }
  }

}
