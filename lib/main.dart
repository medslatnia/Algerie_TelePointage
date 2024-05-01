import 'package:algerie_telecom_pointage/screens/profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:algerie_telecom_pointage/screens/profile_settings.dart';
import 'package:algerie_telecom_pointage/screens/profile.dart';
import 'package:algerie_telecom_pointage/screens/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AT Pointage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: ProfileEditingScreen(),
    );
  }
}
