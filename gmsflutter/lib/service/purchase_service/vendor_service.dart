import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gmsflutter/service/auth_service.dart';
import 'package:gmsflutter/entity/purchase_part/vendor.dart';

class VendorService {
  final String baseUrl = "http://localhost:8080/api/vendor";

  Future<List<Vendor>> fetchVendor() async {

    String? token = await AuthService().getToken();

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("VendorService.fetchVendor: body = ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Vendor.fromJson(e as Map<String, dynamic>)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      throw Exception('Failed to load vendors (${response.statusCode})');
    }
  }

  Future<Vendor> getVendorById(int id) async {
    String? token = await AuthService().getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      return Vendor.fromJson(jsonMap as Map<String, dynamic>);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      throw Exception('Failed to load vendor (${response.statusCode})');
    }
  }
}
