import 'package:flutter/material.dart';
import 'package:scope_demo/models/ItemModel.dart';
import 'package:scope_demo/pages/ItemDetail.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<ShopItemModel> items = ShoppingItems().items;

    print(items);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: InkResponse(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Cart()));
              },
              child: Stack(
                children: [
                  Align(
                    child: Text("1"),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    child: Icon(Icons.shopping_cart),
                    alignment: Alignment.center,
                  ),
                ],
              )
            ),
          )
        ],
      ),
      body: ShopItemListing(items: items,),
    );
  }
}

class ShopItemListing extends StatelessWidget {
  final List<ShopItemModel> items;
  ShopItemListing({required this.items});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
        itemBuilder: (BuildContext context,int index){
          return ItemView(item: items[index],);
        },
        itemCount: items.length,
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final ShopItemModel item;

  ItemView({required this.item});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    // return Padding(
    //   padding: EdgeInsets.all(5),
    //   child: Text("Hello"),
    // );

    return   Padding(
          padding: EdgeInsets.all(5.0),
          child: InkResponse(
            onTap: (){
              print("Tapped");
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> ItemDetailPage())
              );
            },
            child: Material(
              child:Container(
                height: 380.0,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8.0
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 120.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Image.network(item.image,fit: BoxFit.contain,),
                              ),
                            ),
                            Container(
                              child: item.fav ? Icon(Icons.favorite,size: 20.0,color: Colors.red,) : Icon(Icons.favorite_border,size: 20.0,),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("${item.name}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.0,),maxLines: 2,overflow: TextOverflow.ellipsis, ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text("\$${item.price.toString()}",style: TextStyle(fontWeight: FontWeight.w500),),
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
          )
      ),
    );
  }
}