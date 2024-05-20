import 'package:algerie_telecom_pointage/screens/profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:algerie_telecom_pointage/screens/profile_settings.dart';
import 'package:algerie_telecom_pointage/screens/profile.dart';
import 'package:algerie_telecom_pointage/screens/login.dart';
import 'screens/notifications.dart';
import 'screens/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AT Pointage',
      theme:
        ThemeData.from(colorScheme: ColorScheme.light().copyWith(
          background: Color.fromRGBO(238, 238, 238, 1), // Set the background color
        )),

      home: HomeScreen(),
    );
  }
}
