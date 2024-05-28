import 'dart:developer';

import 'package:flutter/material.dart';
import 'home.dart';
import './services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  String _matricule = '';
  String _password = '';
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final double _minimumPadding = 5.0;

  late SharedPreferences _prefs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    getMatricule();
  }

  void _initSharedPreferences() async {
     _prefs = await SharedPreferences.getInstance();
  }

  // Function to load matricule from SharedPreferences
  void getMatricule() async {
     _prefs = await SharedPreferences.getInstance();
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _matricule = _prefs.getString('matricule') ?? '';
    });


  }

  // Function to save matricule to SharedPreferences
  Future<void> setMatricule(String matricule) async {
    print('avant tout $matricule');
   final SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    //print('after all $prefs');
    setState(() {
      prefs.setString('matricule', matricule);
      _matricule = matricule;
      print('nous avons set ce matricule : $_matricule');
    });

  }
  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final matricule = emailController.text;
      final password = passwordController.text;

      try {
        final result = await _authService.login(matricule, password);
        print('Login successful: $result');

        // Enregistrement du matricule dans SharedPreferences

        await setMatricule(matricule);
          print('matricule qui a été set : $_matricule');



        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (error) {
        print('Login failed: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $error')),
        );
      }
    }
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/images/logo.png');
    Image image = Image(
      image: assetImage,
      width: 497.0,
      height: 235.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyLarge;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2556A2),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 1.5),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding * 1.0,
                  bottom: _minimumPadding * 1.0,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: textStyle,
                  controller: emailController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre matricule';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Matricule',
                    hintText: "Veuillez saisir votre matricule",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding * 1.0,
                  bottom: _minimumPadding * 1.0,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: textStyle,
                  controller: passwordController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    hintText: "Veuillez saisir votre mot de passe",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00AA5B),
                        ),
                        child: Text(
                          'Se connecter',
                          textScaleFactor: 1.5,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login();

                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: _minimumPadding * 5),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          print("Forgot Password? button pressed");
                        },
                        child: Text(
                          'Mot de passe oublié?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2556A2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Un problème?"),
                        TextButton(
                          onPressed: () {
                            // Handle button press
                          },
                          child: Text(
                            'Contactez-nous',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF2556A2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
