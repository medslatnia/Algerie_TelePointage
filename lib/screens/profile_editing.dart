import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
import 'package:algerie_telecom_pointage/screens/profile.dart';
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
  late String phoneNumber = "";
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
    setState(() {
      matricule = prefs.getString('matricule') ?? "";
    });

    final response = await http.get(
      Uri.parse('https://yourapiurl.com/api/profile?matricule=$matricule'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        name = data['name'];
        phoneNumber = data['phone_number'];
        email = data['email'];
        password = data['password'];
      });
    } else {
      // Handle error
    }
  }

  Future<void> saveChanges() async {
    final updatedEmail = emailController.text;
    final updatedPhoneNumber = phoneController.text;
    final updatedPassword = passwordController.text;

    // Vérifier que les champs à modifier ne sont pas vides
    if ((updatedEmail.isNotEmpty || updatedPhoneNumber.isNotEmpty || updatedPassword.isNotEmpty)) {
      // Envoie des données mises à jour à votre backend
      final response = await http.post(
        Uri.parse('https://yourapiurl.com/api/update_profile'),
        body: {
          'matricule': matricule,
          if (updatedEmail.isNotEmpty) 'email': updatedEmail,
          if (updatedPhoneNumber.isNotEmpty) 'phone_number': updatedPhoneNumber,
          if (updatedPassword.isNotEmpty) 'password': updatedPassword,
        },
      );

      if (response.statusCode == 200) {
        // Succès, affichez un message de confirmation ou effectuez une action appropriée
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profil mis à jour avec succès'),
            backgroundColor: Colors.green,
          ),
        );
        // Réactualisez également l'affichage si nécessaire
        fetchProfile(); // Réactualisez les données du profil après la mise à jour
      } else {
        // Échec, affichez un message d'erreur ou effectuez une action appropriée
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Échec de la mise à jour du profil'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Afficher un message d'erreur indiquant que tous les champs doivent être remplis
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
            buildTextField("Numéro de Téléphone", phoneNumber, false, controller: phoneController),
            buildTextField("Email", email, false, controller: emailController),
            buildPasswordTextField("Mot de passe", password, controller: passwordController),
            SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              saveChanges();
            },
                child: Text("Sauvegarder", style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 2,
                    color: Colors.white
                )),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00AA5B),
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))

            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String value, bool isReadOnly, {TextEditingController? controller}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: controller,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: value,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
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
          hintText: "******",
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
