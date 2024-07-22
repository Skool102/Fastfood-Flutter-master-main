import 'dart:convert';

import 'package:fastfood/connect/product/product_connect.dart';
import 'package:fastfood/main.dart';
import 'package:fastfood/models/pays/pay_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PayConnectDB {
  static const int _version = 2;
  static const String _dbName = "payment.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute('''
          CREATE TABLE Pay(
          id INTEGER PRIMARY KEY, 
          status TEXT NOT NULL, 
          address TEXT, 
          listProductId TEXT, 
          content TEXT)
'''), version: _version);
  }

  static Future<int> addPay(PayModel pay) async {
    final db = await _getDB();
    return await db.insert("Pay", pay.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updatePay(PayModel pay) async {
    final db = await _getDB();
    return await db.update("Pay", pay.toMap(),
        where: 'id = ${pay.id}',
        whereArgs: [pay.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deletePay(PayModel pay) async {
    final db = await _getDB();
    return await db.delete(
      "Pay",
      where: 'id = ${pay.id}',
      whereArgs: [pay.id],
    );
  }

  static Future<List<PayModel>?> getAllPayUser() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Pay");

    if (maps.isEmpty) {
      return null;
    }

    var listItem =
        List.generate(maps.length, (index) => PayModel.fromJson(maps[index]));
    listItem = listItem.where((e) => e.userId == userLogin!.id).toList();

    return listItem;
  }

  static Future<List<PayModel>?> getAllPayAdmin() async {
    final db = await _getDB();
    final prodctConnect = await ProductConnectDB.getAllProduct();
    final List<Map<String, dynamic>> maps = await db.query("Pay");

    if (maps.isEmpty) {
      return null;
    }

    var listItem =
        List.generate(maps.length, (index) => PayModel.fromJson(maps[index]));

    listItem.forEach((item) {
      
      var dataJson = item.listProductId;
      item.listProduct =
          prodctConnect!.where((c) => dataJson!.contains(c.id.toString())).toList();
    });

    return listItem;
  }
}
