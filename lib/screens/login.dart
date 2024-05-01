import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {

  var _formKey = GlobalKey<FormState>();

  final _minimumPadding = 5.0;

  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();

  String _check() {
    double email = double.parse(emailContoller.text);
    double password = double.parse(passwordContoller.text);
    String result = 'Login success';
    return result;
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/images/logo.png');
    Image image = Image(
      image: assetImage,
      width: 497.0,
      height: 235.0,);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme
        .of(context)
        .textTheme
        .headline6;

    return Scaffold(

      appBar: AppBar(
        title: Text(
            "Login",
            style: TextStyle(color: Colors.white)
        )
        ,
        backgroundColor
            :
        Color
          (
            0xFF2556A2
        )
        ,
      )
      ,

      body:

      Form(
        key: _formKey,
        child:
        Padding(
          padding: EdgeInsets.all(_minimumPadding * 1.5),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding * 1.0,
                      bottom: _minimumPadding * 1.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: textStyle,
                    controller: emailContoller,
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
                        )),
                  )),

              Padding(
                  padding: EdgeInsets.only(
                    top: _minimumPadding * 1.0, bottom: _minimumPadding * 1.0,),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: textStyle,
                    controller: passwordContoller,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Veuillez saisir votre matricule';
                      }
                      return null;
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
                        )),
                  )),

              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF00AA5B),
                          onPrimary: Theme
                              .of(context)
                              .primaryColor,
                        ),
                        child: Text(
                          'Se connecter',
                          textScaleFactor: 1.5,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Form is valid, proceed with form submission or other actions
                            return null; // Placeholder, replace with your actual logic
                          }
                        },


                      ),
                    ),
                  ],
                ),


              )


              ,
              Container
                (
                width: _minimumPadding * 5,
              ),

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
                // Aligns the children to the bottom
                crossAxisAlignment: CrossAxisAlignment.center,
                // Aligns the children to the center horizontally
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Aligns the children horizontally in the center
                      children: [
                        Text("Un problème?"),
                        TextButton(
                          onPressed: () {
                            print("Register Now button pressed");
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