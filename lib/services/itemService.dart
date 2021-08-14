import 'package:scope_demo/models/ItemModel.dart';
import 'package:scope_demo/services/sqlService.dart';
import 'package:scope_demo/services/storageService.dart';

class ItemServices {
  SQLService sqlService = SQLService();
  StorageService storageService = StorageService();
  List<ShopItemModel> shoppingList = [];

  List<ShopItemModel> getShoppingItems() {
    int count = 1;
    data.forEach((element) {
      element['id'] = count;
      shoppingList.add(ShopItemModel.fromJson(element));
      count++;
    });
    return shoppingList;
  }

  List<ShopItemModel> get items => getShoppingItems();

  loadItems() async {
    var flag = await sqlService.openDB();
    print(flag);
    bool isFirst = await isFirstTime();
    print("IS FIRST $isFirst");
    if (isFirst) {
      // Load From local DB
      getLocalDBRecord();
    } else {
      // Save Record into DB
      saveToLocalDB();
    }
  }

  Future<bool> isFirstTime() async {
    return await storageService.getItem("isFirstTime") == 'true';
  }

  saveToLocalDB() async {
    try {
      List<ShopItemModel> items = this.items;
      for(var i=0; i<items.length; i++) {
       await sqlService.saveRecord(items[i]);
      }
      storageService.setItem("isFirstTime","true");
      getLocalDBRecord();
    } catch (e) {
      print("ERROR WHILE SAVE TO LOACAL $e");
    }
  }

  getLocalDBRecord() async {
    try {
      sqlService.getItemsRecord();
    } catch (e) {
      print("ERROR IN GET LOCAL DB RECORD $e");
    }
  }

  addToCard() {}

  removeFromCard() {}
}
