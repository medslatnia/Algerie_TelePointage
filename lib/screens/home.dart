import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constants.dart';
import 'profile_editing.dart';
import 'login.dart';
import 'notifications.dart';
import 'profile.dart';
import 'windows/mois.dart';
import 'windows/quitter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Accueil",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
          backgroundColor: Color.fromRGBO(37, 86, 162, 1),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 33, 143, 36),
                              // Couleur de fond du Container
                              borderRadius: BorderRadius.circular(
                                  20), // Optionnel: coins arrondis
                            ),
                            child: SizedBox(
                              width: 150, // Largeur souhaitée du bouton
                              height: 150,
                              child: MaterialButton(
                                color: Color.fromARGB(255, 33, 143, 36),
                                onPressed: () {
                                  // Action à exécuter lors du clic sur le bouton
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // Couleur de fond du Container
                                        borderRadius: BorderRadius.circular(
                                            10), // Optionnel: coins arrondis
                                      ),
                                      child: Icon(Icons.check,
                                          color:
                                              Color.fromARGB(255, 33, 143, 36),
                                          size: 34),
                                    ),
                                    SizedBox(width: 20),
                                    // Espacement entre l'icône et le texte
                                    Text(
                                      "S'enregistrer",
                                      style: TextStyle(
                                          fontSize: 20,
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    // Texte du bouton
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          child: Expanded(
                            child: SizedBox(
                              width: 150, // Largeur souhaitée du bouton
                              height: 150,
                              child: MaterialButton(
                                color: Color.fromARGB(255, 7, 78, 136),
                                onPressed: () async {
                                  final quitternon = await showDialog(
                                    context: context,
                                    builder: (context) =>
                                        Quitterannuler(), // Affichez le dialogue de quitterannuler
                                  );
                                  //faire qlq chose avec quitternon
                                },

                                // Action à exécuter lors du clic sur le bouton

                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // Couleur de fond du Container
                                        borderRadius: BorderRadius.circular(
                                            10), // Optionnel: coins arrondis
                                      ),
                                      child: Icon(
                                        Icons.exit_to_app,
                                        color: Color.fromARGB(255, 7, 78, 136),
                                        size: 34,
                                      ),
                                    ),

                                    SizedBox(width: 20),
                                    // Espacement entre l'icône et le texte
                                    Text(
                                      'Sortir',
                                      style: TextStyle(
                                          fontSize: 20,
                                          //fontWeight: FontWeight.bold,
                                          color:
                                              Colors.white), // Texte du bouton
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Expanded(
                child: Container(
                  //height: 300,
                  //width: 180,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.dehaze, //3 Traits
                          size: 38,
                          color: Colors.black,
                        ),
                        //onPressed: () {
                        onPressed: () async {
                          final moisSelectionne = await showDialog(
                            context: context,
                            builder: (context) =>
                                MoisSelectorDialog(), // Affichez le dialogue de sélection de mois
                          );

                          // Faites quelque chose avec la valeur sélectionnée, par exemple :
                          print("Mois sélectionné : $moisSelectionne");
                        },
                      ),

                      //Icon(Icons.dehaze, size: 38.0),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Historique",
                        style: TextStyle(
                            fontSize: 23,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
