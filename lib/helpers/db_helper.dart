import 'package:ave_assignment8/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // constants
  static const dbName = "product_db.db";
  static const dbVersion = 1;
  
  static const tbName = "products";
  static const colId = "id";
  static const colSku = "sku";
  static const colName = "name";
  static const colDescription = "description";
  static const colPrice = "price";
  static const coldDiscountedPrice = "discountedPrice";
  static const colQuantity = "quantity";
  static const colManufacturer = "manufacturer";

  // methods
   // creating the table
  static Future<Database> openDB() async {
    var path = join(await getDatabasesPath(), DbHelper.dbName); 
    var sql = "CREATE TABLE IF NOT EXISTS $tbName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colSku TEXT, $colName TEXT, $colDescription TEXT, $colPrice DECIMAL(10, 4), $coldDiscountedPrice DECIMAL(10, 4), $colQuantity INT, $colManufacturer TEXT)";
    var db = await openDatabase(
      path, 
      version: DbHelper.dbVersion,
      onCreate: (db, version) {
        db.execute(sql);
        print("table $tbName created");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (newVersion <= oldVersion) return;
        db.execute("DROP TABLE IF EXISTS $tbName");
        db.execute(sql);
        print("droppped and recreated");
      }
    );
    return db;
  }

   // inserting the product
  static void insertProduct(Product p) async {
    final db = await openDB();
    var id = await db.insert(
      tbName, 
      p.toMapWithoudId(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('inserted id: $id');
  }
   // fetiching the records
  static Future<List<Map<String, dynamic>>> fetchQuery() async {
    final db = await openDB();
    return await db.query(tbName);
  }
    // pag delete
  static void deleteRaw(int id) async {
    final db = await openDB();
    var num = await db.rawDelete('DELETE FROM $tbName WHERE $colId = $id');
    print('deleted $num rows');
  }
    // pag update
  static void updateProduct(Product p) async {
    final db = await openDB();
    db.update(
      tbName, 
      p.toMap(),
      where: '$colId = ?',
      whereArgs: [p.id],
    );
  }
}
