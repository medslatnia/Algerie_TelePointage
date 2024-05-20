import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constants.dart';
import 'package:algerie_telecom_pointage/screens/profile.dart';

class ProfileEditingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileEditingScreenState();
  }
}

class ProfileEditingScreenState extends State<ProfileEditingScreen> {
  bool isObscurePassword = true;
  @override
  Widget build(BuildContext context) { return
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Modifier son profil",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            backgroundColor: Color.fromRGBO(37, 86, 162, 1),
          ),

          body:
          Container(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15),
            child: GestureDetector(
              onTap:(){
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children:[
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(width:2, color: Colors.grey),
                            boxShadow:[
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1)
                              )
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/avatar.png'),
                            )
                          ),
                        ),
                        Positioned(
                            bottom: 00,
                            right: 00,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width:4,
                                  color:Colors.white,
                                ),
                                color: Colors.grey,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:30),
                  buildTextField("Nom", "Ramy BENSID", false),
                  buildTextField("Email", "RamyB90@gmail.com", false),
                  buildTextField("Numéro de téléphone", "0589134785", false),
                  buildTextField("Mot de passe", "*******", true),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileScreen()),
                        );
                      },
                      child: Text("Annuler",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing:2,
                          color:Colors.black
                      ),),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    ),
                    ElevatedButton(onPressed: (){},
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


                  ],)
                ],
              ) ,
            ),
          ),



        );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField){
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField?
              IconButton(
                icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                onPressed:(){}
              ):null,
          contentPadding: EdgeInsets.only(bottom:5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:Colors.grey,
          )
        ),
      ),
    );
  }

}