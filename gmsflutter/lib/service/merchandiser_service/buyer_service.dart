import 'dart:convert';

import 'package:gmsflutter/entity/merchandiser_part/buyer.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;
class BuyerService{
  final String baseUrl = "http://localhost:8080/api/buyer";

  Future<List<Buyer>> fetchBuyers() async {
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

    // 3️⃣ Handle response
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Buyer.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      throw Exception('Failed to load Buyers (${response.statusCode})');
    }
  }
}



