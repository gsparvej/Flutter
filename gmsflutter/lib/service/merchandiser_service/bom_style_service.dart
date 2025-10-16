import 'dart:convert';
import 'package:gmsflutter/entity/merchandiser_part/bom.dart';
import 'package:gmsflutter/entity/merchandiser_part/bom_style.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class BomStyleService {
  final String baseUrl = "http://localhost:8080/api";

  Future<List<BomStyle>> fetchAllBomStyles() async {
    // 1️⃣ Get token from AuthService
    String? token = await AuthService().getToken();

    // 2️⃣ Call API with Authorization header
    final response = await http.get(
      Uri.parse(baseUrl+'/bomstyle'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    //  Handle response
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => BomStyle.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      throw Exception('Failed to load BomStyle (${response.statusCode})');
    }
  }
  Future<List<BOM>> getBOMByStyleCode(String styleCode) async {
    String? token = await AuthService().getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/bom/style/$styleCode'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded.map<BOM>((json) => BOM.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      throw Exception('Failed to load BOM list (${response.statusCode})');
    }
  }


}
