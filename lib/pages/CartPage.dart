import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scope_demo/controller/homePageController.dart';
import 'package:scope_demo/models/ItemModel.dart';

class CartPage extends StatelessWidget {
  Widget generateCart(ShopItemModel d) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white12,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 1.0),
              top: BorderSide(color: Colors.grey.shade100, width: 1.0),
            )),
        height: 100.0,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 5.0)
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                  image: DecorationImage(
                      image: NetworkImage(d.image), fit: BoxFit.fill)),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          d.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: InkResponse(
                          onTap: () {
                            // model.removeCart(d);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Price ${d.price.toString()}"),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart list"),
      ),
      body: GetBuilder<HomePageController>(
        builder: (_) {
          print(controller.cartItems.length);
          return ListView(
            shrinkWrap: true,
            children: controller.cartItems.map((d) => generateCart(d)).toList(),
          );
        },
      ),
    );
  }
}
