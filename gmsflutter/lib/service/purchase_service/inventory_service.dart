import 'dart:convert';


import 'package:gmsflutter/entity/purchase_part/inventory.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class InventoryService {
  final String baseUrl = "http://localhost:8080/api/inventory";

  Future<List<Inventory>> fetchInventories() async {
    // 1️⃣ Get token from AuthService
    String? token = await AuthService().getToken();

    // 2️⃣ Call API with Authorization header
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    //  Handle response
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Inventory.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      throw Exception('Failed to load Buyers (${response.statusCode})');
    }
  }
}
