import 'dart:convert';


import 'package:gmsflutter/entity/merchandiser_part/uom.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class UomService{
  final String baseUrl = "http://localhost:8080/api/uom";
  Future<List<Uom>> fetchUom() async {
    String? token = await AuthService().getToken();

    if (token == null) {
      throw Exception('No token found. Please login again.');
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Uom.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token.');
    } else {
      throw Exception('Failed to load UOM (${response.statusCode})');
    }
  }

}