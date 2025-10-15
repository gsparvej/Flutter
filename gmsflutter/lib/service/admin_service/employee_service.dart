import 'dart:convert';
import 'package:gmsflutter/entity/admin_entity/employee.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class EmployeeService{

  static const String baseUrl = 'http://localhost:8080/api';

  Future<List<Employee>> fetchAllEmployee() async {
    try {
      // Get token
      String? token = await AuthService().getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      // 2️⃣ Make API call
      final response = await http.get(
        Uri.parse('$baseUrl/employee'),
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
        print('Fetched Employees: $data');

        // 4️⃣ Parse each item safely
        List<Employee> employee = data.map((json) {
          try {
            return Employee.fromJson(json);
          } catch (e) {
            print("Failed to parse Employee: $json\nError: $e");
            return null; // Skip invalid item
          }
        }).whereType<Employee>().toList(); // Filters out nulls

        return employee;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token');
      } else {
        print("Unexpected error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to load Employee (${response.statusCode})');
      }
    } catch (e) {
      print('Error in fetchAllEmployee(): $e');
      rethrow;
    }
  }

}