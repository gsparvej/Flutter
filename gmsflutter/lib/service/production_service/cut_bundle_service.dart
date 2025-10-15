
import 'dart:convert';
import 'package:gmsflutter/entity/production_entities/cut_bundle.dart';
import 'package:gmsflutter/entity/production_entities/cutting_plan.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class CutBundleService{
  static const String baseUrl = 'http://localhost:8080/api';

  Future<bool> addCutBundle(CutBundle cutBundle) async {

    String? token = await AuthService().getToken();

    final response = await http.post(
      Uri.parse(baseUrl+'/cutBundle'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cutBundle.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Error: ${response.statusCode} ${response.body}');
      return false;
    }
  }

  Future<List<CuttingPlan>> getCuttingPlan() async {
    final response = await http.get(Uri.parse('$baseUrl/cutting_plan'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => CuttingPlan.fromJson(e)).toList();
    }
    throw Exception('Failed to load cutting plan');
  }



  Future<List<CutBundle>> fetchCutBundle() async {
    try {
      // 1️⃣ Get token
      String? token = await AuthService().getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      // 2️⃣ Make API call
      final response = await http.get(
        Uri.parse('$baseUrl/cutBundle'),
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
        print('Fetched cut bundles: $data');

        // 4️⃣ Parse each item safely
        List<CutBundle> bundles = data.map((json) {
          try {
            return CutBundle.fromJson(json);
          } catch (e) {
            print("Failed to parse item: $json\nError: $e");
            return null; // Skip invalid item
          }
        }).whereType<CutBundle>().toList(); // Filters out nulls

        return bundles;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token');
      } else {
        print("Unexpected error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to load Cut Bundles (${response.statusCode})');
      }
    } catch (e) {
      print('Error in fetchCutBundle(): $e');
      rethrow;
    }
  }




}