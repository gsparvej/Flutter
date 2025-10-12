import 'dart:convert';
import 'package:gmsflutter/entity/purchase_part/full_requisition.dart';
import 'package:gmsflutter/entity/purchase_part/purchase_order.dart';
import 'package:gmsflutter/entity/purchase_part/requisition_list_entity.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class PurchaseOrderService {
  final String baseUrl = "http://localhost:8080/api";

  Future<List<PurchaseOrder>> fetchPOs() async {
    // 1️⃣ Get token from AuthService
    String? token = await AuthService().getToken();

    // 2️⃣ Call API with Authorization header
    final response = await http.get(
      Uri.parse(baseUrl+'/po'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    //  Handle response
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PurchaseOrder.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      throw Exception('Failed to load Purchase Orders (${response.statusCode})');
    }
  }

  Future<PurchaseOrder> getPOsById(int id) async {
    String? token = await AuthService().getToken();

    final response = await http.get(
      Uri.parse(baseUrl + '/po/id/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List && decoded.isNotEmpty) {
        return PurchaseOrder.fromJson(decoded[0]); // Use first element
      } else {
        throw Exception('Empty list received from server');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      throw Exception('Failed to load Purchase Order Details (${response.statusCode})');
    }
  }

}
