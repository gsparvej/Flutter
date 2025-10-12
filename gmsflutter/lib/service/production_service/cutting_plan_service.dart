import 'dart:convert';

import 'package:gmsflutter/entity/production_part/cutting_plan.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class CuttingPlanService{

  static const String baseUrl = 'http://localhost:8080/api';

  Future<List<CuttingPlan>> fetchCuttingPlan() async {
    try {
      // 1️⃣ Get token
      String? token = await AuthService().getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      // 2️⃣ Make API call
      final response = await http.get(
        Uri.parse('$baseUrl/cutting_plan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // 3️⃣ Check response
      if (response.statusCode == 200) {
        final body = response.body;

        if (body.isEmpty) {
          throw Exception('Empty response body');
        }

        List<dynamic> data = jsonDecode(body);

        // 🛠️ Debug print to inspect raw data
        print('Fetched cutting Plans: $data');

        // 4️⃣ Parse each item safely
        List<CuttingPlan> bundles = data.map((json) {
          try {
            return CuttingPlan.fromJson(json);
          } catch (e) {
            print("Failed to parse item: $json\nError: $e");
            return null; // Skip invalid item
          }
        }).whereType<CuttingPlan>().toList(); // Filters out nulls

        return bundles;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token');
      } else {
        print("Unexpected error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to load Cutting Plan (${response.statusCode})');
      }
    } catch (e) {
      print('Error in fetchCuttingPlan(): $e');
      rethrow;
    }
  }

}