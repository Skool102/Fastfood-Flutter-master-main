import 'package:fastfood/models/user/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserConnectDB {
  static const int _version = 1;
  static const String _dbName = "fastFood.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE User(id INTEGER PRIMARY KEY, email TEXT NOT NULL, passWord TEXT NOT NULL, userName TEXT, fullName TEXT, numberPhone TEXT, isManager NUMERIC);"),
        version: _version);
  }

  static Future<int> adduser(User user) async {
    final db = await _getDB();
    return await db.insert("User", user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateuser(User user) async {
    final db = await _getDB();
    return await db.update("User", user.toMap(),
        where: 'id = ${user.id}',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteuser(User user) async {
    final db = await _getDB();
    return await db.delete(
      "User",
      where: 'id = ${user.id}',
      whereArgs: [user.id],
    );
  }

  static Future<List<User>?> getAlluser() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("User");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }

    static Future<List<User>?> getUser(User user) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("User");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }


}
