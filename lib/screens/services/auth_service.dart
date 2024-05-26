import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

class AuthService {
  final String apiUrl = 'http://10.0.2.2:8000/api/login';

  //vG0xyRDNvB
  Future<Map<String, dynamic>> login(String matricule, String password) async {
    try {
      //log('1'+ matricule+password);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'matricule': matricule,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('Mauvaise données');
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
