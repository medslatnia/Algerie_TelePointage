import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileEditingScreenState();
  }
}

class ProfileEditingScreenState extends State<ProfileEditingScreen> {
  late String name = "";
  late String matricule = "";
  late String phone = "";
  late String email = "";
  late String password = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt_token');

    if (token == null) {
      print("le token est vide");
      return;
    }

    const String apiUrl = 'http://10.0.2.2:8000/api/employe/getInfoEmploye';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          name = data['name'] ?? "";
          matricule = data['matricule'] ?? "";
          email = data['email'] ?? "";
          phone = data['phone'] ?? "";
        });
      } else {
        // Gérer l'erreur
        print('Erreur lors de la récupération du profil: ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion
      print('Failed to send request: $e');
    }
  }

  Future<void> saveChanges() async {
    final updatedEmail = emailController.text;
    final updatedPhoneNumber = phoneController.text;
    final updatedPassword = passwordController.text;

    if (updatedEmail.isNotEmpty || updatedPhoneNumber.isNotEmpty || updatedPassword.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/employe/updateProfile'),
        body: {
          'matricule': matricule,
          if (updatedEmail.isNotEmpty) 'email': updatedEmail,
          if (updatedPhoneNumber.isNotEmpty) 'phone_number': updatedPhoneNumber,
          if (updatedPassword.isNotEmpty) 'password': updatedPassword,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profil mis à jour avec succès'),
            backgroundColor: Colors.green,
          ),
        );
        fetchProfile();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Échec de la mise à jour du profil'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tous les champs sont vides'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Modifier son profil",
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
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(height: 20),
            buildTextField("Nom", name, true),
            buildTextField("Matricule", matricule, true),
            buildTextField("Numéro de Téléphone", phone, false, controller: phoneController),
            buildTextField("Email", email, false, controller: emailController),
            buildPasswordTextField("Mot de passe", password, controller: passwordController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveChanges();
              },
              child: Text(
                "Sauvegarder",
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00AA5B),
                padding: EdgeInsets.symmetric(horizontal: 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String value, bool isReadOnly, {TextEditingController? controller}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: isReadOnly ? TextEditingController(text: value) : controller,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: isReadOnly ? null : value,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(),
          filled: isReadOnly,
          fillColor: isReadOnly ? Colors.grey[200] : null,
        ),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildPasswordTextField(String labelText, String value, {TextEditingController? controller}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: "********",
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
