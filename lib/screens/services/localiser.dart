import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import '../windows/checkin.dart';
import '../windows/noncheckin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

bool estAuBonEndroit = false;

const double LAT = 37.4219983;
const double LON = -122.084;
const double tolerance = 0.0009;// une tolérence de 100 mètres = 0.0009 degrés

// Fonction pour détecter la localisation
Future<bool> detecterLocalisation(BuildContext context, double Lat, double Lon, double toleranceDegrees) async {
  double minLat = Lat - toleranceDegrees;
  double maxLat = Lat + toleranceDegrees;
  double minLon = Lon - toleranceDegrees;
  double maxLon = Lon + toleranceDegrees;

  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    print('Permission de localisation refusée.');
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  double latitude = position.latitude;
  double longitude = position.longitude;

  print('Latitude requise: ($minLat - $maxLat), Longitude requise: ($minLat - $maxLat)');
  print('Latitude actuelle: $latitude, Longitude actuelle: $longitude');

  if (latitude >= minLat && latitude <= maxLat &&
      longitude >= minLon && longitude <= maxLon) {
    // Effectuer une action lorsque l'utilisateur est au bon endroit
    print('L\'utilisateur est au bon endroit.');
    return estAuBonEndroit= true;

  } else {
    // Effectuer une action lorsque l'utilisateur n'est pas au bon endroit
    print('L\'utilisateur n\'est pas au bon endroit.');
    return estAuBonEndroit=false;
  }
}

Future<void> sendCheckInRequest() async {
  // Récupérer le token depuis SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('jwt_token');
  print('token récupéré dans localiser : $token');

  if (token != null) {
    // URL de l'endpoint pour la requête POST
    const String apiUrl = 'http://10.0.2.2:8000/api/employe/checkIn';

    final Map<String, dynamic> body = {
    };

    // En-têtes de la requête avec le token JWT
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        //body: jsonEncode(body),
      );

      // Gérer la réponse
      if (response.statusCode == 200) {
        // Succès de la requête
        print('Request successful: ${response.body}');
      } else {
        // Gérer les erreurs de la requête
        print('Failed to send request: ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion
      print('Failed to send request: $e');
    }
  } else {
    // Gérer le cas où le token n'est pas trouvé dans SharedPreferences
    print('Token not found in SharedPreferences');
  }
}

Future<void> sendCheckOutRequest() async {
  // Récupérer le token depuis SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('jwt_token');
  print('$token');

  if (token != null) {
    // URL de l'endpoint pour la requête POST
    const String apiUrl = 'http://10.0.2.2:8000/api/employe/checkOut';
    final Map<String, dynamic> body = {
    };

    // En-têtes de la requête avec le token JWT
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      print("avant checkout");

      // Gérer la réponse
      if (response.statusCode == 200) {
        // Succès de la requête
        print('Request successful: ${response.body}');
      } else {
        // Gérer les erreurs de la requête
        print('Failed to send request: ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion
      print('Failed to send request: $e');
    }
  } else {
    // Gérer le cas où le token n'est pas trouvé dans SharedPreferences
    print('Token not found in SharedPreferences');
  }
}

Future<void> sendEmergencyCheckOutRequest() async {
  // Récupérer le token depuis SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('jwt_token');
  print('$token');

  if (token != null) {
    // URL de l'endpoint pour la requête POST
    const String apiUrl = 'http://10.0.2.2:8000/api/employe/checkOut';

    final Map<String, dynamic> body = {
      'statut': 'emergency',
    };

    // En-têtes de la requête avec le token JWT
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );
print("emergency checkout");

      // Gérer la réponse
      if (response.statusCode == 200) {
        // Succès de la requête
        print('Request successful: ${response.body}');
      } else {
        // Gérer les erreurs de la requête
        print('Failed to send request: ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion
      print('Failed to send request: $e');
    }
  } else {
    // Gérer le cas où le token n'est pas trouvé dans SharedPreferences
    print('Token not found in SharedPreferences');
  }
}