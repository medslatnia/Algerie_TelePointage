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
        width: 333,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            mainAxisExtent: 40,
          ),
          children: [
            RadioListTile(
              activeColor: Color.fromARGB(255, 33, 143, 36),
              title: Text("Janvier"),
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
                title: Text("Juillet"),
                value: "Juillet",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Février"),
                value: "Février",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Aout"),
                value: "Aout",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Mars"),
                value: "Mars",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Septembre"),
                value: "Septembre",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Avril"),
                value: "Avril",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Octobre"),
                value: "Octobre",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Mai"),
                value: "Mai",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Novembre"),
                value: "Novembre",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Juin"),
                value: "Juin",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),
            RadioListTile(
                activeColor: Color.fromARGB(255, 33, 143, 36),
                title: Text("Décembre"),
                value: "Décembre",
                groupValue: moisSelectionne,
                onChanged: (val) {
                  setState(() {
                    moisSelectionne = val;
                  });
                }),

            // Ajoutez les autres RadioListTile pour les autres mois ici...
          ],
        ),
      ),
    );
  }
}