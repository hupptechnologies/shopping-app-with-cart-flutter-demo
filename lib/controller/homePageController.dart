import 'package:get/get.dart';
import 'package:scope_demo/models/ItemModel.dart';
import 'package:scope_demo/services/itemService.dart';

class HomePageController extends GetxController {
  ItemServices itemServices = ItemServices();
  List<ShopItemModel> items = [];
  List<ShopItemModel> cartItems = [];
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadDB();
  }

  loadDB() async {
    await itemServices.openDB();
    loadItems();
    getCardList();
  }

  getItem(int id) {
    return items.singleWhere((element) => element.id == id);
  }

  getCardList() async{
    try {
      List list = await itemServices.getCartList();
      list.forEach((element) {
        cartItems.add(ShopItemModel.fromJson(element));
      });
      update();

    } catch (e) {
      print(e);
    }
  }

  loadItems()async{
    try {
      isLoading = true;
      update();

      List list = await itemServices.loadItems();
      list.forEach((element) {
        items.add(ShopItemModel.fromJson(element));
      });

      isLoading = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  setToFav(int id, bool flag) async {
    int index = items.indexWhere((element) => element.id == id);

    items[index].fav = flag;
    update();
    try {
      await itemServices.setItemAsFavourite(id, flag);
    } catch (e) {
      print(e);
    }
  }

  Future addToCart(ShopItemModel item) async {
    return await itemServices.addToCart(item);
  }
}