import 'dart:convert';
import 'package:gmsflutter/entity/merchandiser_part/raw_materials_check.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class RawMaterialsCheckService{
  final String baseUrl = "http://localhost:8080/api/raw_materials";
  Future<List<RawMaterialsCheck>> fetchRawMaterials() async {
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
      return data.map((json) => RawMaterialsCheck.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token.');
    } else {
      throw Exception('Failed to load Raw Materials Check (${response.statusCode})');
    }
  }

}