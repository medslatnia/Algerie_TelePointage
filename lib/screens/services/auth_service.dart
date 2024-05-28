import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Ajout de l'importation pour SharedPreferences
import 'dart:developer';


//vG0xyRDNvB
class AuthService {
  final String apiUrl = 'http://10.0.2.2:8000/api/login';

  Future<Map<String, dynamic>> login(String matricule, String password) async {
    try {
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
        // Décoder la réponse JSON
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extraire le token
        final String token = responseData['access_token'];

        // Stocker le token dans SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        log("le token a été enregistré dans SharedPreferences");

        // Retourner les données de la réponse
        return responseData;
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
