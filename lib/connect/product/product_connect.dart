import 'package:fastfood/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductConnectDB {
  static const int _version = 1;
  static const String _dbName = "product.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Product(id INTEGER PRIMARY KEY, title TEXT NOT NULL, address TEXT,name TEXT NOT NULL,label TEXT, price NUMERIC, image TEXT, description TEXT, rating TEXT, duration TEXT);"),
        version: _version);
  }

  static Future<int> addProduct(Product product) async {
    final db = await _getDB();
    return await db.insert("Product", product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateProduct(Product product) async {
    final db = await _getDB();
    return await db.update("Product", product.toMap(),
        where: 'id = ${product.id}',
        whereArgs: [product.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteProduct(Product product) async {
    final db = await _getDB();
    return await db.delete(
      "Product",
      where: 'id = ${product.id}',
      whereArgs: [product.id],
    );
  }

  _query(productId) async {
    final db = await _getDB();
    // raw query
    List<Map> result =
        await db.rawQuery('SELECT * FROM product.db WHERE id=$productId');

    // print the results
    result.forEach((row) => print(row));
    // {_id: 2, name: Mary, age: 32}
  }

  static Future<List<Product>?> getAllProduct() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Product");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
  }
}
