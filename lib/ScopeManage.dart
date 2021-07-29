import 'dart:io';

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

var data = [
  {
    "name": "Nike",
    "price": 25.0,
    "fav": true,
    "rating": 4.5,
    "image":
        "https://rukminim1.flixcart.com/image/832/832/jao8uq80/shoe/3/r/q/sm323-9-sparx-white-original-imaezvxwmp6qz6tg.jpeg?q=70"
  },
  {
    "name": "Brasher Traveller Brasher Traveller ",
    "price": 200.0,
    "fav": true,
    "rating": 4.5,
    "image":
        "https://cdn-image.travelandleisure.com/sites/default/files/styles/1600x1000/public/merrell_0.jpg?itok=wFRPiIPw"
  },
  {
    "name": "Puma Descendant Ind",
    "price": 299.0,
    "fav": false,
    "rating": 4.5,
    "image":
        "https://n4.sdlcdn.com/imgs/d/h/i/Asian-Gray-Running-Shoes-SDL691594953-1-2127d.jpg"
  },
  {
    "name": "Running Shoe Brooks Highly",
    "price": 3001.0,
    "fav": true,
    "rating": 3.5,
    "image":
        "https://cdn.pixabay.com/photo/2014/06/18/18/42/running-shoe-371625_960_720.jpg"
  },
  {
    "name": "Ugly Shoe Trends 2018",
    "price": 25.0,
    "fav": true,
    "rating": 4.5,
    "image":
        "https://pixel.nymag.com/imgs/fashion/daily/2018/04/18/uglee-shoes/70-fila-disruptor.w710.h473.2x.jpg"
  },
  {
    "name": "Nordstrom",
    "price": 214.0,
    "fav": false,
    "rating": 4.0,
    "image":
        "https://n.nordstrommedia.com/ImageGallery/store/product/Zoom/9/_100313809.jpg?h=365&w=240&dpr=2&quality=45&fit=fill&fm=jpg"
  },
  {
    "name": "ShoeGuru",
    "price": 205.0,
    "fav": true,
    "rating": 4.0,
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc_R7jxbs8Mk2wjW9bG6H9JDbyEU_hRHmjhr3EYn-DYA99YU6zIw"
  },
  {
    "name": "shoefly black",
    "price": 200.0,
    "fav": false,
    "rating": 4.9,
    "image":
        "https://rukminim1.flixcart.com/image/612/612/j95y4cw0/shoe/d/p/8/sho-black-303-9-shoefly-black-original-imaechtbjzqbhygf.jpeg?q=70"
  }
];

class StorageService {
  setItem(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  getItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    return value;
  }

  deleteItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class AppModel extends Model {
  List<Item> _items = [];
  List<Data> _data = [];
  List<Data> shoppingItems = [];
  List<Data> _cart = [];
  String cartMsg = "";
  bool success = false;
  Database? _db;
  Directory? tempDir;
  String? tempPath;
  StorageService storage = StorageService();

  AppModel() {
    // Create DB Instance & Create Table
    createDB();
  }

  deleteDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cart.db');

    await deleteDatabase(path);
    if (storage.getItem("isFirst") != null) {
      await storage.deleteItem("isFirst");
    }
  }

  createDB() async {
    try {
      // Get a location using getDatabasesPath
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'cart.db');

      openDatabase(path, version: 1, onOpen: (Database db) {
        this._db = db;
        print("OPEN DBV");
        this.createTable();
      }, onCreate: (Database db, int version) async {
        this._db = db;
        print("DB Crated");
      });
    } catch (e) {
      print("ERRR >>>>@@@@");
      print(e);
    }
  }

  createTable() async {
    try {
      var qry = "CREATE TABLE IF NOT EXISTS shopping ( "
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "image Text,"
          "price REAL,"
          "fav INTEGER,"
          "rating REAL,"
          "datetime DATETIME)";
      await this._db?.execute(qry);
      qry = "CREATE TABLE IF NOT EXISTS cart_list ( "
          "id INTEGER PRIMARY KEY,"
          "shop_id INTEGER,"
          "name TEXT,"
          "image Text,"
          "price REAL,"
          "fav INTEGER,"
          "rating REAL,"
          "datetime DATETIME)";

      await this._db?.execute(qry);

      var _flag = await storage.getItem("isFirst");
      if (_flag == "true") {
        print("IF");
        this.fetchDataFromDB();
        // this.FetchCartList();
      } else {
        print("ELSE");
        this.insertInLocal();
      }
    } catch (e) {
      print(e);
    }
  }

  fetchDataFromDB() async {
    try {

      List<Map> list = await this._db!.rawQuery('SELECT * FROM shopping');
      print(list);
      shoppingItems.clear();
      notifyListeners();

      list.map((dd) {
        Data tmpData = Data(
          name: dd["name"],
          id: dd["id"],
          image: dd["image"],
          price: dd["price"],
          rating: dd["rating"],
          shop_id: 0,
          fav: dd["fav"] == 1 ? true : false,
        );
        shoppingItems.add(tmpData);
        notifyListeners();
      }).toList();
      print(shoppingItems.length);

    } catch (e) {
      print(e);
    }
  }

  FetchLocalData() async {
    try {
      // Get the records
      List<Map> list = await this._db!.rawQuery('SELECT * FROM shopping');
      _data = [];
      notifyListeners();
      list.map((dd) {
        Data d = new Data(
            name: dd["name"],
            id: dd["id"],
            image: dd["image"],
            price: dd["price"],
            rating: dd["rating"],
            shop_id: 0,
            fav: dd["fav"] == 1 ? true : false);
        _data.add(d);
        notifyListeners();
      }).toList();
    } catch (e) {
      print(e);
    }
  }

  insertInLocal() async {
    try {
      await storage.setItem("isFirst", "true");

      await this._db?.transaction((tx) async {
        for (var i = 0; i < data.length; i++) {
          dynamic tmpData = data[i];
          Data d = new Data(
              name: tmpData["name"],
              id: i + 1,
              image: tmpData["image"],
              price: tmpData["price"],
              rating: tmpData["rating"],
              shop_id: 0,
              fav: tmpData["fav"] == 1 ? true : false);

          var qry =
              'INSERT INTO shopping(name, price, image,rating,fav) VALUES("${d.name}",${d.price}, "${d.image}",${d.rating},${d.fav ? 1 : 0})';
          await tx.rawInsert(qry);
        }
        FetchLocalData();
      });
    } catch (e) {
      print(e);
    }
  }

  InsertInCart(Data d) async {
    await this._db!.transaction((tx) async {
      try {
        var qry =
            'INSERT INTO cart_list(shop_id,name, price, image,rating,fav) VALUES(${d.id},"${d.name}",${d.price}, "${d.image}",${d.rating},${d.fav ? 1 : 0})';
        var _res = await tx.execute(qry);
        this.FetchCartList();
      } catch (e) {
        print("ERRR @@ @@");
        print(e);
      }
    });
  }

  FetchCartList() async {
    try {
      // Get the records
      _cart = [];
      List<Map> list = await this._db!.rawQuery('SELECT * FROM cart_list');
      list.map((dd) {
        Data d = new Data(
            name: dd["name"],
            id: dd["id"],
            image: dd["image"],
            price: dd["price"],
            rating: dd["rating"],
            shop_id: dd["shop_id"],
            fav: dd["fav"] == 1 ? true : false);
        _cart.add(d);
      }).toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  UpdateFavItem(Data data) async {
    try {
      var qry =
          "UPDATE shopping set fav = ${data.fav ? 1 : 0} where id = ${data.id}";
      this._db!.rawUpdate(qry).then((res) {}).catchError((e) {
        print("UPDATE ERR ${e}");
      });
    } catch (e) {
      print("ERRR @@");
      print(e);
    }
  }

  // Add In fav list
  addToFav(Data data) {
    var _index = _data.indexWhere((d) => d.id == data.id);
    data.fav = !data.fav;
    _data.insert(_index, data);
    this.UpdateFavItem(data);
    notifyListeners();
  }

  // Item List
  List<Data> get itemListing => shoppingItems;

  // Item Add
  void addItem(Data dd) {
    // Data d = new Data();
    Data d = new Data(
        name: dd.name,
        id: data.length + 1,
        image: dd.image,
        price: dd.price,
        rating: dd.rating,
        shop_id: dd.shop_id ?? 0,
        fav: dd.fav);
    d.id = _data.length + 1;
    d.name = "New";
    d.image =
        "https://rukminim1.flixcart.com/image/832/832/jao8uq80/shoe/3/r/q/sm323-9-sparx-white-original-imaezvxwmp6qz6tg.jpeg?q=70";
    d.price = 154.0;
    d.fav = false;
    d.rating = 4.0;
    _data.add(d);
    notifyListeners();
  }

  // Cart Listing
  List<Data> get cartListing => _cart;

  // Add Cart
  void addCart(Data dd) {
    print(dd);
    print(_cart);
    int _index = _cart.indexWhere((d) => d.shop_id == dd.id);
    if (_index > -1) {
      success = false;
      cartMsg = "${dd.name.toUpperCase()} already added in Cart list.";
    } else {
      this.InsertInCart(dd);
      success = true;
      cartMsg = "${dd.name.toUpperCase()} successfully added in cart list.";
    }
  }

  RemoveCartDB(Data d) async {
    try {
      var qry = "DELETE FROM cart_list where id = ${d.id}";
      this._db!.rawDelete(qry).then((data) {
        print(data);
        int _index = _cart.indexWhere((dd) => dd.id == d.id);
        _cart.removeAt(_index);
        notifyListeners();
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print("ERR rm cart${e}");
    }
  }

  // Remove Cart
  void removeCart(Data dd) {
    this.RemoveCartDB(dd);
  }
}

class Item {
  final String name;

  Item(this.name);
}

class Data {
  String name;
  int? id;
  String image;
  double? rating;
  double? price;
  bool fav;
  int? shop_id;

  Data({
    required this.id,
    this.fav = false,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    this.shop_id,
  });
}
