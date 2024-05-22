import 'package:algerie_telecom_pointage/screens/windows/checkout.dart';
import 'package:algerie_telecom_pointage/screens/windows/noncheckin.dart';
import 'package:algerie_telecom_pointage/screens/windows/noncheckout.dart';
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
import 'windows/checkin.dart';
import 'package:geolocator/geolocator.dart';
import 'services/localiser.dart';
import 'package:algerie_telecom_pointage/screens/historique/database_helper.dart';
import 'package:algerie_telecom_pointage/screens/historique/historique.dart';

List<Map<String, dynamic>> historique = [];
DateTime? heureEntree;
DateTime? heureSortie;

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
      resizeToAvoidBottomInset: true,
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
        padding: EdgeInsets.fromLTRB(20, 0, 20, 150),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height *
                  0.3, // ajustez la hauteur selon vos besoins
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 33, 143, 36),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: MaterialButton(
                            color: Color.fromARGB(255, 33, 143, 36),
                            onPressed: () async {
                              detecterLocalisation(
                                  context, LAT, LON, tolerance);
                              await Future.delayed(Duration(milliseconds: 800));
                              if (estAuBonEndroit == true) {
                                DateTime heureEntree =
                                    DateTime.now(); // Heure de sortie actuelle
                                historique.add({
                                  'date': DateTime.now(),
                                  'heureEntree': heureEntree,
                                  'heureSortie': null,
                                });

                                await showDialog(
                                  context: context,
                                  builder: (context) => checkin(),
                                );
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (context) => noncheckin(),
                                );
                              }
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.check,
                                      color: Color.fromARGB(255, 33, 143, 36),
                                      size: 34),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "S'enregistrer",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: MaterialButton(
                            color: Color.fromARGB(255, 7, 78, 136),
                            onPressed: () async {
                              final quitternon = await showDialog(
                                context: context,
                                builder: (context) => Quitterannuler(),
                              );
                              //faire qlq chose avec quitternon
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.exit_to_app,
                                      color: Color.fromARGB(255, 7, 78, 136),
                                      size: 34),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Sortir',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0),
              // Définir les marges en haut et en bas
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.dehaze, size: 38, color: Colors.black),
                    onPressed: () async {
                      final moisSelectionne = await showDialog(
                        context: context,
                        builder: (context) => MoisSelectorDialog(),
                      );
                      print("Mois sélectionné : $moisSelectionne");
                    },
                  ),
                  SizedBox(width: 2),
                  Text(
                    "Historique",
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: historique.length,
                itemBuilder: (context, index) {
                  final reversedIndex = historique.length - 1 - index;
                  final date = historique[reversedIndex]['date'];
                  final entree = historique[reversedIndex]['heureEntree'];
                  final sortie = historique[reversedIndex]['heureSortie'];

                  // Conditions pour l'icône d'erreur
                  bool isErreur = false;
                  if (entree != null && entree.hour > 8) {
                    isErreur = true;
                  } else if (sortie != null && sortie.hour < 16) {
                    isErreur = true;
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(
                      leading: Icon(
                        isErreur
                            ? Icons.error
                            : sortie != null
                                ? Icons.check_circle
                                : Icons.access_time,
                        color: isErreur
                            ? Colors.red
                            : sortie != null
                                ? Colors.green
                                : Colors.orange,
                      ),
                      title: Text(
                        'Date: ${date.toLocal().toIso8601String().split('T').first}',
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Entrée: ${entree.toLocal().toIso8601String().split('T').last.substring(0, 5)}',
                          ),
                          sortie != null
                              ? Text(
                                  'Sortie: ${sortie.toLocal().toIso8601String().split('T').last.substring(0, 5)}',
                                )
                              : Text('Sortie: Non enregistré'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
