class Historique {
  final int id;
  final DateTime date;
  final DateTime heureEntree;
  final DateTime heureSortie;

  Historique({
    required this.id,
    required this.date,
    required this.heureEntree,
    required this.heureSortie,
  });

  // Convert a Historique into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'heureEntree': heureEntree.toIso8601String(),
      'heureSortie': heureSortie.toIso8601String(),
    };
  }

  // Convert a Map into a Historique
  factory Historique.fromMap(Map<String, dynamic> map) {
    return Historique(
      id: map['id'],
      date: DateTime.parse(map['date']),
      heureEntree: DateTime.parse(map['heureEntree']),
      heureSortie: DateTime.parse(map['heureSortie']),
    );
  }
}