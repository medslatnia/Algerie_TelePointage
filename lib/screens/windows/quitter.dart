import 'package:flutter/material.dart';

class Quitterannuler extends StatefulWidget {
  const Quitterannuler({super.key});

  @override
  State<Quitterannuler> createState() => _QuitterannulerState();
}

class _QuitterannulerState extends State<Quitterannuler> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 57,
        width: 400,
        child: Row(children: [
          Icon(
            Icons
                .error, // Utilisez l'icône d'erreur pour le point d'exclamation
            size: 40.0, // Taille de l'icône
            color: Color.fromARGB(255, 160, 14, 3), // Couleur de l'icône
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              "Etes-Vous surs de vouloir quitter?",
              style: TextStyle(
                //fontWeight: FontWeight.bold,
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
                  borderRadius: BorderRadius.circular(20), // Bord circulaire
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
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 33, 143, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bord circulaire
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


