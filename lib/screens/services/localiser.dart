import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import '../windows/checkin.dart';
import '../windows/noncheckin.dart';

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

  // Vérifie si la permission de localisation est accordée
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    print('Permission de localisation refusée.');
  }

  // Récupère la position actuelle
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Récupère la latitude et la longitude de la position actuelle
  double latitude = position.latitude;
  double longitude = position.longitude;

  // Affiche les coordonnées
  print('Latitude requise: ($minLat - $maxLat), Longitude requise: ($minLat - $maxLat)');
  print('Latitude actuelle: $latitude, Longitude actuelle: $longitude');


  // Ici vous pouvez faire ce que vous voulez avec les coordonnées, par exemple les utiliser dans votre application
  if (latitude >= minLat && latitude <= maxLat &&
      longitude >= minLon && longitude <= maxLon)  {
      //await Future.delayed(Duration(seconds: 2));
    return estAuBonEndroit = true;
  } else {
      //await Future.delayed(Duration(seconds: 2));
    return estAuBonEndroit = false;


    // faire quelque chose après la fermeture de la boîte de dialogue
  }

}