import 'package:flutter/material.dart';

class checkout extends StatefulWidget {
  const checkout({super.key});

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 57,
        width: 400,
        child: Row(children: [
          Icon(
            Icons.check_circle_outline,
            size: 40.0, // Taille de l'icône
            color: Color.fromARGB(255, 33, 143, 36), // Couleur de l'icône
          ),
          SizedBox(width: 45),
          Expanded(
            child: Text(
              "Sorti !",
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
                "Quitter",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
        )
      ],
    );
  }
}
