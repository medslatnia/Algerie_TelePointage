import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'historique.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('historique.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE historique (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      heureEntree TEXT NOT NULL,
      heureSortie TEXT NOT NULL
    )
    ''');
  }

  Future<List<Historique>> fetchHistoriques() async {
    final db = await instance.database;

    final result = await db.query('historique');

    return result.map((json) => Historique.fromMap(json)).toList();
  }

  Future<int> insertHistorique(Historique historique) async {
    final db = await instance.database;
    return await db.insert('historique', historique.toMap());
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}