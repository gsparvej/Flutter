
import 'dart:convert';
import 'package:gmsflutter/entity/production_entities/machine.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:http/http.dart' as http;

class MachineService{
  static const String baseUrl = 'http://localhost:8080/api';

  Future<bool> addMachine(Machine machine) async {

    String? token = await AuthService().getToken();

    final response = await http.post(
      Uri.parse(baseUrl+'/machine'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(machine.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Error: ${response.statusCode} ${response.body}');
      return false;
    }
  }

  Future<List<Machine>> fetchMachine() async {
    try {
      // Get token
      String? token = await AuthService().getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      // 2️⃣ Make API call
      final response = await http.get(
        Uri.parse('$baseUrl/machine'),
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
        print('Fetched Machines: $data');

        // 4️⃣ Parse each item safely
        List<Machine> machines = data.map((json) {
          try {
            return Machine.fromJson(json);
          } catch (e) {
            print("Failed to parse item: $json\nError: $e");
            return null; // Skip invalid item
          }
        }).whereType<Machine>().toList(); // Filters out nulls

        return machines;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token');
      } else {
        print("Unexpected error: ${response.statusCode} - ${response.body}");
        throw Exception('Failed to load Machine (${response.statusCode})');
      }
    } catch (e) {
      print('Error in fetchMachine(): $e');
      rethrow;
    }
  }




}