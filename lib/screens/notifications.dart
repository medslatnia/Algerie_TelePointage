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
  late String matricule = "";
  late List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchMatricule();
  }

  Future<void> fetchMatricule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      matricule = prefs.getString('matricule') ?? "";
    });
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final response = await http.get(
      Uri.parse('https://yourapiurl.com/api/notifications?matricule=$matricule'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        notifications = List<Map<String, dynamic>>.from(data['notifications']);
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: buildNotificationsList(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        "Notifications",
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Color.fromRGBO(37, 86, 162, 1),
    );
  }

  Widget buildNotificationsList() {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return buildNotificationItem(notifications[index]);
      },
    );
  }

  Widget buildNotificationItem(Map<String, dynamic> notification) {
    return ListTile(
      leading: Icon(
        Icons.notifications,
        color: Colors.white,
      ),
      title: Text(
        'Admin',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        notification['content'],
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
