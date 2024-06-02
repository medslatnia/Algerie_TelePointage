import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:algerie_telecom_pointage/screens/windows/checkout.dart';
import 'package:algerie_telecom_pointage/screens/windows/noncheckin.dart';
import 'package:algerie_telecom_pointage/screens/windows/noncheckout.dart';
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
import 'services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

final ApiService apiService = ApiService();
List<Map<String, dynamic>> historique = [];
DateTime? heureEntree;
DateTime? heureSortie;
bool enregistrementEffectue = false;
bool sortieEffectue = false;

String dates = "";
String check_in = "";
String check_out = "";
String statut = "";
int NombrePointages = 0;

String check_in_hour = "";
String check_out_hour = "";

late int pointage_Id = 0;

void showJustificationDialog(BuildContext context, int pointage_id) async {
  final TextEditingController _controller = TextEditingController();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Justification'),
        content: Container(
          height: 100, // Ou toute autre hauteur appropriée
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Merci de bien renseigner le justificatif d\'absence ici',
            ),
            maxLines: 3,
          ),
        ),

        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              String justification = _controller.text.trim();
              if (justification.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Ce champ est vide',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              else {_sendJustification(context, justification, pointage_Id);}
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF00AA5B), // Couleur du texte
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rayon des coins
              ),
            ),
            child: Text('Envoyer'), // Texte du bouton
          )
        ],
      );
    },
  );
}


Future<void> _sendJustification(BuildContext context, String justification, int pointage_Id) async {
  final url = 'http://10.0.2.2:8000/api/employe/addJustification';

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('jwt_token');

  if (token == null) {
    print("le token est vide");
    return;
  }

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'pointing_id': pointage_Id,
      'text': justification,
    }),
  );


  if (response.statusCode == 200 || response.statusCode == 201) {
    _showConfirmationDialog(context, 'Justification envoyée avec succès');
  }
   else if (response.statusCode == 400) {
    _showConfirmationDialog(context, 'Justificatif existe déjà !');
  }
  else {
    print(response.statusCode);
    _showConfirmationDialog(context, 'Échec de l\'envoi de la justification');
  }
}

void _showConfirmationDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Notification'),
          ],
        ),
        content: Text('$message'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, // Couleur du texte
              backgroundColor: Color(0xFF00AA5B), // Couleur de fond
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rayon des coins
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  late String _matricule;



  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    resetStatesAtMidnight();
    fetchHistorique();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _matricule = _prefs.getString('matricule') ?? '';
  }
  void resetStatesAtMidnight() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);

    Duration durationUntilMidnight = midnight.difference(now);

    Timer(durationUntilMidnight, () {
      setState(() {
        enregistrementEffectue = false;
        sortieEffectue = false;
      });
      resetStatesAtMidnight(); // Réinitialiser à minuit chaque jour
    });
  }



  Future<void> fetchHistorique() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt_token');

     String dateHistorique = (DateTime.now().year.toString()) + "-" + (DateTime.now().month >=10 ?  DateTime.now().month.toString() :("0"+ DateTime.now().month.toString()));


    if (token == null) {
      print("le token est vide");
      return;
    }

     String apiUrl = "http://10.0.2.2:8000/api/employe/getPointing?date=$dateHistorique";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['pointings'] != null && data['pointings'].length > 0) {
          setState(() {
            NombrePointages =data['pointings'].length;
            for(int i=0; i<data['pointings'].length; i++) {
              historique.add(data['pointings'][i]);
            }

          });
        }
      } else {
        // Gérer l'erreur
        print('Erreur lors de la récupération de l\'historique: ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion
      print('Failed to send request: $e');
    }
  }


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
        padding: EdgeInsets.fromLTRB(20, 0, 20, 80),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: enregistrementEffectue
                ? Color.fromARGB(255, 51, 193, 56) // Couleur plus claire
                      : Color.fromARGB(255, 33, 143, 36),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: MaterialButton(
                            color: Color.fromARGB(255, 33, 143, 36),
                            onPressed: !enregistrementEffectue ? () async {
                              detecterLocalisation(context, LAT, LON, tolerance);
                              await Future.delayed(Duration(seconds: 2));
                              if (estAuBonEndroit == true && estDejaEnregistre == false) {
                                sendCheckInRequest();

                                setState(() {
                                  enregistrementEffectue = true;
                                });
                                await
                                 showDialog(
                                  context: context,
                                  builder: (context) => checkin(),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Un problème est survenu, veuillez réessayer'),
                                        backgroundColor: Colors.red),
                                );
                                await
                                 showDialog(
                                  context: context,
                                  builder: (context) => noncheckin(),

                                );
                              }
                            } : null,
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
                                  enregistrementEffectue ? "Enregistré" : "S'enregistrer",
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
                            onPressed: enregistrementEffectue && !sortieEffectue ? () async {

                              final quitternon = await showDialog(
                                context: context,
                                builder: (context) => Quitterannuler(),
                              );
                              if(isSortieEffectue()){print("ici");}
                            } : null,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Historique",
                    style: TextStyle(
                      fontSize:23,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: NombrePointages,

                itemBuilder: (context, index) {

                  final reversedIndex = NombrePointages - 1 - index;

                  dates = historique[reversedIndex]['date'] ?? "";
                  check_in = historique[reversedIndex]['check_in'] ?? "";
                  check_out = historique[reversedIndex]['check_out'] ?? "";



                  String date = dates;
                  String entree = check_in;
                  entree = entree!= "" ? entree.substring(0,2): "";

                  String sortie = check_out;
                  sortie = sortie!= "" ? sortie.substring(0,2):"";

                  check_in_hour = check_in;

                  check_in_hour = check_in!="" ? check_in.substring(0,5): "";

                  check_out_hour = check_out;
                  check_out_hour = check_out!="" ? check_out.substring(0,5): "";

                  // Conditions pour l'icône d'erreur
                  bool isErreur = false;
                  bool isInProgress = false;
                  if (entree != "" && int.parse(entree) > 8) {
                    isErreur = true;
                  } else if (sortie != "" && int.parse(sortie) < 16) {
                    isErreur = true;
                  }
                  if(int.parse(entree) <= 8 && sortie == "" ) {
                    isInProgress = true;
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(

                      leading: GestureDetector(
                        onTap: () {
                          // Action à effectuer lorsque l'icône est cliquée
                          if (isErreur) {
                            int i = NombrePointages - 1 - index;
                            pointage_Id = historique[i]['pointing_id'] ?? -1 ;

                            showJustificationDialog(context, pointage_Id);
                          }
                        },
                        child: Icon(
                          isErreur == true
                              ? Icons.error
                              : isInProgress == true
                              ? Icons.access_time
                              : Icons.check_circle,
                          color: isErreur == true
                              ? Colors.red
                              : isInProgress == true
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                      title: Text(
                        'Date: $date',
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Entrée: $check_in_hour',
                          ),
                          sortie != ""
                              ? Text(
                            'Sortie: $check_out_hour',
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

