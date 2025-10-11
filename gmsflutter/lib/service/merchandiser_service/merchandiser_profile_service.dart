import 'dart:convert';


import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;




class MerchandiserManagerService {
  final String baseUrl =  "http://localhost:8080";

  Future<Map<String , dynamic>?> getMerchandiserManagerProfile() async {
    String? token = await AuthService().getToken();

    if(token == null) {
      print('Token Not Found, Please login first.');
      return null;
    }
    final url = Uri.parse('$baseUrl/api/merchan_manager/profile');
    final response = await http.get(
      url,
      headers: {
        'Authorization' : 'Bearer $token',
        'Content-Type' : 'application/json'
      },
    );
    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to load profile : ${response.statusCode} - ${response.body}');
      return null;
    }




  }

}