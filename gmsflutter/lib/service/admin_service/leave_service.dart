import 'dart:convert';
import 'package:gmsflutter/entity/admin_entity/attendance.dart';
import 'package:gmsflutter/entity/admin_entity/leave.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class LeaveService{

  static const String baseUrl = 'http://localhost:8080/api';

  Future<List<Leave>> fetchAllLeaves() async {
    try {
      // Get token
      String? token = await AuthService().getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      // 2️⃣ Make API call
      final response = await http.get(
        Uri.parse('$baseUrl/leave'),
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
        print('Fetched Leave: $data');

        // 4️⃣ Parse each item safely
        List<Leave> leave = data.map((json) {
          try {
            return Leave.fromJson(json);
          } catch (e) {
            print("Failed to parse Attendance: $json\nError: $e");
            return null; // Skip invalid item
          }
        }).whereType<Leave>().toList(); // Filters out nulls

        return leave;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token');
      } else {
        print("Unexpected error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to load Leave (${response.statusCode})');
      }
    } catch (e) {
      print('Error in fetchAllLeaves(): $e');
      rethrow;
    }
  }

}