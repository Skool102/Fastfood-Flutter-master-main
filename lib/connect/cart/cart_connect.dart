import 'package:fastfood/connect/product/product_connect.dart';
import 'package:fastfood/main.dart';
import 'package:fastfood/models/cart/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartConnectDB {
  static const int _version = 1;
  static const String _dbName = "cart.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Cart(id INTEGER PRIMARY KEY,productId INTEGER NOT NULL, price NUMERIC, quantity INTEGER, userId INTEGER);"),
        version: _version);
  }

  static Future<int> addCart(CartModel cart) async {
    final db = await _getDB();
    return await db.insert("Cart", cart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateCart(CartModel cart) async {
    final db = await _getDB();
    return await db.update("Cart", cart.toMap(),
        where: 'id = ?',
        whereArgs: [cart.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteCart(CartModel cart) async {
    final db = await _getDB();
    return await db.delete(
      "Cart",
      where: 'id = ${cart.id}',
      whereArgs: [cart.id],
    );
  }

  static Future<List<CartModel>?> getAllCart() async {
    final db = await _getDB();
    final prodctConnect = await ProductConnectDB.getAllProduct();
    final List<Map<String, dynamic>> maps = await db.query("Cart");

    if (maps.isEmpty) {
      return null;
    }

    var listItem =
        List.generate(maps.length, (index) => CartModel.fromJson(maps[index]));
    // listItem = listItem.where((e) => e.userId == userLogin!.id).toList();
    listItem.forEach((e) {
      e.productData =
          prodctConnect!.where((d) => e.productId == d.id).firstOrNull;
    });
    listItem = listItem.where((r) => r.userId == userLogin!.id).toList();
    return listItem;
  }
}
