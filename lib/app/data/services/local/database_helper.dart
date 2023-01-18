import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_product_local/app/data/models/products_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Products.db";

  //get db products
  static Future<Database> _getDBProducts() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
          "CREATE TABLE Products(id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, qty INTEGER NOT NULL, price INTEGER NOT NULL)"),
      version: _version,
    );
  }

  //Create Products
  static Future<int> addProduct(Product product) async {
    final db = await _getDBProducts();
    return await db.insert("Products", product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Update Products
  static Future<int> updateProduct(Product product) async {
    final db = await _getDBProducts();
    return await db.update("Products", product.toJson(),
        where: 'id = ?',
        whereArgs: [product.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Delete Products
  static Future<int> deleteProduct(Product product) async {
    final db = await _getDBProducts();
    return await db
        .delete("Products", where: 'id = ?', whereArgs: [product.id]);
  }

  static Future<List<Product>?> getAllProducts() async {
    final db = await _getDBProducts();

    final List<Map<String, dynamic>> maps = await db.query("Products");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
  }
}
