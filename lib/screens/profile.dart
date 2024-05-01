import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constants.dart';
import 'profile_editing.dart';
import 'login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}



class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
        backgroundColor: Color.fromRGBO(37, 86, 162, 1),
      ),
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height:30),

                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileEditingScreen()),
                  );
                },
                    child: Text("Modifier", style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white
                    )),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF00AA5B),
                        padding: EdgeInsets.symmetric(horizontal: 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),

                buildTextField("Nom", "Mohammed BENSID"),
                buildTextField("Matricule", "19880505"),
                buildTextField("Numéro de Téléphone", "0589134785"),
                buildTextField("Email", "RamyB90@gmail.com"),

                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                    child: Text("Se déconnecter", style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white
                    )),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),
                SizedBox(height:30),
              ],
            ),
          ),
        ),
      // You can add your profile content here
    );

  }
  Widget buildTextField(String labelText, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        readOnly: true, // Make the text field non-editable
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: value,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

}
