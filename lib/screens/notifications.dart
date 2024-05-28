import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationsScreenState();
  }
}

class NotificationsScreenState extends State<NotificationsScreen> {
  List notifications = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt_token');

    if (token == null) {
      print("Le token est vide");
      return;
    }

    const String apiUrl = 'http://10.0.2.2:8000/api/employe/getNotification';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Succès de la requête
        print('Request successful: ${response.body}');
        final data = jsonDecode(response.body);

        setState(() {
          notifications = data['notifications'];
        });
      } else {
        // Gérer les erreurs de la requête
        print('Failed to send request: ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion
      print('Failed to send request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(37, 86, 162, 1),
        iconTheme: IconThemeData(color: Colors.white), // Couleur de l'icône de retour
      ),
      body: notifications.isEmpty
          ? Center(child: Text("Aucune notification", style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white, // Fond blanc
            child: ListTile(
              leading: Icon(Icons.notifications, color: Colors.black), // Icône de notification en noir
              title: Text(
                'Admin',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Titre "Notifications" en noir
              ),
              subtitle: Text(notifications[index]['text'] ?? "Pas de contenu", style: TextStyle(color: Colors.black)), // Texte de la notification en noir
            ),
          );
        },
      ),
    );
  }
}
