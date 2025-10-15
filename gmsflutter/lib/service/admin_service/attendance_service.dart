import 'dart:convert';
import 'package:gmsflutter/entity/admin_entity/attendance.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class AttendanceService{

  static const String baseUrl = 'http://localhost:8080/api';

  Future<List<Attendance>> fetchAllAttendance() async {
    try {
      // Get token
      String? token = await AuthService().getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      // 2️⃣ Make API call
      final response = await http.get(
        Uri.parse('$baseUrl/attendance'),
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
        print('Fetched Attendance: $data');

        // 4️⃣ Parse each item safely
        List<Attendance> attendance = data.map((json) {
          try {
            return Attendance.fromJson(json);
          } catch (e) {
            print("Failed to parse Attendance: $json\nError: $e");
            return null; // Skip invalid item
          }
        }).whereType<Attendance>().toList(); // Filters out nulls

        return attendance;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token');
      } else {
        print("Unexpected error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to load Attendance (${response.statusCode})');
      }
    } catch (e) {
      print('Error in fetchAllAttendance(): $e');
      rethrow;
    }
  }

}