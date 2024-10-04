import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService {
  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'meals.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE meals(idMeal TEXT PRIMARY KEY, strMeal TEXT, strMealThumb TEXT)"
        );
      },
    );
  }

  Future<void> saveMeals(List<Map<String, dynamic>> meals) async {
    final db = await this.db;
    for (var meal in meals) {
      await db.insert('meals', meal, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Map<String, dynamic>>> getMeals() async {
    final db = await this.db;
    return await db.query('meals');
  }
}
