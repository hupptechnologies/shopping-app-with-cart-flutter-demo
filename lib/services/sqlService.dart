import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLService {
  Database? db;

  openDB() async {
    try {

      // Get a location using getDatabasesPath
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'shopping.db');

      // open the database
      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          this.db = db;
          createTables();
        },
        onOpen: (Database db) {
          this.db = db;
        }
      );
    } catch (e) {
      print("ERROR IN OPEN DATABASE $e");
    }
  }

  createTables() async {
    try {
      var qry = "CREATE TABLE IF NOT EXISTS shopping ( "
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "image Text,"
          "price REAL,"
          "fav INTEGER,"
          "rating REAL,"
          "datetime DATETIME)";
      await db?.execute(qry);
      qry = "CREATE TABLE IF NOT EXISTS cart_list ( "
          "id INTEGER PRIMARY KEY,"
          "shop_id INTEGER,"
          "name TEXT,"
          "image Text,"
          "price REAL,"
          "fav INTEGER,"
          "rating REAL,"
          "datetime DATETIME)";

      await db?.execute(qry);
    } catch (e) {
      print("ERROR IN CREATE TABLE");
      print(e);
    }
  }

  Future saveRecord(dynamic data) async {
    try {
      return await db?.transaction((tx) async {
        try {
          print("CALLED>>>");
          var qry =
              'INSERT INTO shopping(shop_id,name, price, image,rating,fav) VALUES(${data['id']},"${data['name']}",${data['price']}, "${data['image']}",${data['rating']},${data['fav'] ? 1 : 0})';
          return  tx.execute(qry);
        } catch (e) {
          print(e);
          return Future.error(e);
        }
      });
    } catch (e) {
      print("ERROR IN SAVE RECORD $e");
      return Future.error(e);
    }
  }

  Future getItemsRecord() async {
    try {
      var list = await db?.rawQuery('SELECT * FROM shopping',[]);
      print(list);
      return list;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
