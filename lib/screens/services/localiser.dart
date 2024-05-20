import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import '../windows/checkin.dart';
import '../windows/noncheckin.dart';

// Fonction pour détecter la localisation
void detecterLocalisation(BuildContext context, double Lat, double Lon, double toleranceDegrees) async {

  double minLat = Lat - toleranceDegrees;
  double maxLat = Lat + toleranceDegrees;
  double minLon = Lon - toleranceDegrees;
  double maxLon = Lon + toleranceDegrees;


  // Vérifie si la permission de localisation est accordée
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    print('Permission de localisation refusée.');
    return;
  }

  // Récupère la position actuelle
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Récupère la latitude et la longitude de la position actuelle
  double latitude = position.latitude;
  double longitude = position.longitude;

  // Affiche les coordonnées
  print('Latitude: $latitude, Longitude: $longitude');

  // Ici vous pouvez faire ce que vous voulez avec les coordonnées, par exemple les utiliser dans votre application
  if (latitude >= minLat && latitude <= maxLat &&
      longitude >= minLon && longitude <= maxLon)  {
    await showDialog(
        context: context,
        builder: (context) => checkin());
  } else {
    await showDialog(
      context: context,
      builder: (context) => noncheckin(), // Affichez le dialogue de quitterannuler
    );
    // faire quelque chose après la fermeture de la boîte de dialogue
  }
}