import 'package:flutter/material.dart';

class MoisSelectorDialog extends StatefulWidget {
  @override
  _MoisSelectorDialogState createState() => _MoisSelectorDialogState();
}

class _MoisSelectorDialogState extends State<MoisSelectorDialog> {
  String? moisSelectionne = "Janvier";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choisir un mois"),
      content: Container(
        height: 270,
        width: 700,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 0,
            mainAxisExtent: 35,
          ),
          children: [
            RadioListTile(
              activeColor: Color.fromARGB(255, 33, 143, 36),
              title: Text("Janvier", style: TextStyle(fontSize: 13),),

              value: "Janvier",
              groupValue: moisSelectionne,
              onChanged: (val) {
                setState(() {
                  moisSelectionne = val;
                });
                //Navigator.of(context).pop(
                // moisSelectionne); // Fermer le dialogue après la sélection et renvoyer la valeur sélectionnée
              },
            ),

            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Juillet", style: TextStyle(fontSize: 13),),
                value: "Juillet",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Février", style: TextStyle(fontSize: 13),),
                value: "Février",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Aout", style: TextStyle(fontSize: 13),),
                value: "Aout",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Mars", style: TextStyle(fontSize: 13),),
                value: "Mars",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Septembre", style: TextStyle(fontSize: 13),),
                value: "Septembre",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Avril", style: TextStyle(fontSize: 13),),
                value: "Avril",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Octobre", style: TextStyle(fontSize: 13),),
                value: "Octobre",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Mai", style: TextStyle(fontSize: 13),),
                value: "Mai",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Novembre", style: TextStyle(fontSize: 13),),
                value: "Novembre",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Juin", style: TextStyle(fontSize: 13),),
                value: "Juin",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Décembre", style: TextStyle(fontSize: 13),),
                value: "Décembre",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),


          ],
        ),
      ),
    );
  }
}