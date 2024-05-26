import 'dart:convert';
import 'package:http/http.dart' as http;
import '../home.dart';

class ApiService {
  final String apiUrl = 'http://votre-backend-url/api'; // Remplacez par votre URL de backend

  Future<void> enregistrerHeureEntree(String matricule, DateTime heureEntree) async {
    final url = Uri.parse('$apiUrl/heure_entree');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'matricule': matricule,
        'heure': heureEntree.toIso8601String(),
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to register entry hour');
    }
  }

  Future<void> enregistrerHeureSortie(String matricule, DateTime heureSortie, bool emergency) async {
    final url = Uri.parse('$apiUrl/heure_sortie');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'matricule': matricule,
        'heure': heureSortie.toIso8601String(),
        'emergency': emergency
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to register exit hour');
    }
  }
}