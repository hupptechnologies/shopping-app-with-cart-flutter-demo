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
    await sqlService.openDB();
    bool isFirst = await isFirstTime();

    if (isFirst) {
      // Load From local DB
      List items = await getLocalDBRecord();
      return items;
    } else {
      // Save Record into DB & load record
      List items = await saveToLocalDB();
      return items;
    }
  }

  Future<bool> isFirstTime() async {
    return await storageService.getItem("isFirstTime") == 'true';
  }

  Future saveToLocalDB() async {
    List<ShopItemModel> items = this.items;
    for(var i=0; i<items.length; i++) {
     await sqlService.saveRecord(items[i]);
    }
    storageService.setItem("isFirstTime","true");
    return await getLocalDBRecord();
  }

  Future getLocalDBRecord() async {
    return await sqlService.getItemsRecord();
  }

  addToCard() {}

  removeFromCard() {}
}
