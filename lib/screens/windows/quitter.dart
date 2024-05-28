import 'package:flutter/material.dart';
import '../services/localiser.dart';
import '../home.dart';
import 'checkout.dart';
import 'noncheckout.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isSortieEffectue() {
  return sortieEffectue;
}


class Quitterannuler extends StatefulWidget {
  const Quitterannuler({Key? key}) : super(key: key);

  @override
  State<Quitterannuler> createState() => _QuitterannulerState();
}

Future<DateTime> obtenirHeureSortie() async {
  // Simuler un délai pour obtenir l'heure de sortie
  await Future.delayed(Duration(seconds: 1));
  return DateTime.now();
}

class _QuitterannulerState extends State<Quitterannuler> {
  late SharedPreferences _prefs;
  late String _matricule;
  bool Emergency = false;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _matricule = _prefs.getString('matricule') ?? '';
    });
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 57,
        width: 400,
        child: Row(children: [
          Icon(
            Icons.error,
            size: 40.0,
            color: Color.fromARGB(255, 160, 14, 3),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              "Etes-Vous surs de vouloir quitter?",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ]),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 7, 78, 136),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Annuler",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () async {
                detecterLocalisation(context, LAT, LON, tolerance);
                await Future.delayed(Duration(seconds: 1));
                if (estAuBonEndroit && historique.isNotEmpty) {

                  DateTime heureSortie = DateTime.now();
                  historique[historique.length - 1]['heureSortie'] = heureSortie;

                  if (heureSortie.hour < 16) {
                    sendEmergencyCheckOutRequest();
                  }
                  else {
                    sendCheckOutRequest();
                  }

                  //await apiService.enregistrerHeureSortie(_matricule, heureSortie, Emergency);
                  setState(() {
                    bool sortieEffectue = true;
                  });

                  await showDialog(
                    context: context,
                    builder: (context) => checkout(),
                  );
                } else {
                  await showDialog(
                    context: context,
                    builder: (context) =>
                        noncheckout(), // Affichez le dialogue de quitterannuler
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 33, 143, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Quitter",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
