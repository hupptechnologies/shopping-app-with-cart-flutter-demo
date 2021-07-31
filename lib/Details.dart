// import "package:flutter/material.dart";
// import "package:scoped_model/scoped_model.dart";
// import "ScopeManage.dart";
// import "dart:async";
//
// class Details extends StatefulWidget{
//
//   static String route = "Home-route";
//
//   final Data detail;
//
//   Details({required this.detail});
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return DetailsState();
//   }
// }
//
// class DetailsState extends State<Details>{
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   PageController _controller = PageController();
//   int active =0;
//
//
//
//   Widget buildDot(int index,int num){
//     return Padding(
//       padding: EdgeInsets.all(5.0),
//       child: Container(
//         height: 10.0,
//         width: 10.0,
//         decoration: BoxDecoration(
//
//             color: (num == index ) ? Colors.black38 : Colors.grey[200],
//             shape: BoxShape.circle
//         ),
//       ),
//     );
//   }
//
//   showSnak(bool flag,String name){
//     // ScaffoldMessenger.of(_scaffoldKey.currentContext).showSnackBar(SnackBar(
//     //   content: Text(flag ? "${name} added in favourite list" : "${name} removed from favourite list"),
//     //   duration: Duration(seconds: 2),
//     // ));
//
//     // _scaffoldKey.currentState.showSnackBar(
//     //     SnackBar(
//     //       content: Text(flag ? "${name} added in favourite list" : "${name} removed from favourite list"),
//     //       duration: Duration(seconds: 2),
//     //     ));
//   }
//
//   showCartSnak(String msg,bool flag){
//     // _scaffoldKey.currentState.showSnackBar(
//     //     SnackBar(
//     //       content: Text(msg,style: TextStyle(color: Colors.white),),
//     //       backgroundColor: (flag) ? Colors.green : Colors.red[500] ,
//     //       duration: Duration(seconds: 2),
//     //     ));
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return SafeArea(
//       bottom: false,
//       top: false,
//       child: Scaffold(
//           key: _scaffoldKey,
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             title: Text("CONVERSE"),
//             elevation: 0.0,
//           ),
//           body: Container(
//             decoration: BoxDecoration(
//                 border: Border(
//                     top: BorderSide(
//                       color: Colors.grey.shade300,
//                         // color: Colors.grey[300],
//                         width: 1.0
//                     )
//                 )
//             ),
//             child: ListView(
//               children: <Widget>[
//                 Stack(
//                   children: <Widget>[
//                     Container(
//                       height: 280.0,
//                       padding: EdgeInsets.only(top: 10.0),
//                       color: Colors.white,
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                             height: 200.0,
//                             child: PageView(
//                               controller: _controller,
//                               onPageChanged: (index){
//                                 print(index);
//                                 setState(() {
//                                   active = index;
//                                 });
//                               },
//                               children: <Widget>[
//                                 Image.network(widget.detail.image,height: 150.0,),
//                                 Image.network(widget.detail.image,height: 150.0,),
//                                 Image.network(widget.detail.image,height: 150.0,),
//                                 Image.network(widget.detail.image,height: 150.0,)
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10.0,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               buildDot(active,0),
//                               buildDot(active,1),
//                               buildDot(active,2),
//                               buildDot(active,3)
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                         height: 270.0,
//                         alignment: Alignment(1.0, 1.0),
//                         child: Padding(
//                           padding: EdgeInsets.only(right: 15.0),
//                           child: Column(
//                             verticalDirection: VerticalDirection.down,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: <Widget>[
//                               ScopedModelDescendant<AppModel>(
//                                 builder: (context,child,model){
//                                   return GestureDetector(
//                                     onTap: (){
//                                       print(widget.detail.id);
//                                       model.addToFav(widget.detail);
//                                       showSnak(widget.detail.fav,widget.detail.name);
//                                     },
//                                     child: widget.detail.fav ? Icon(Icons.favorite,size: 20.0,color: Colors.red,) : Icon(Icons.favorite_border,size: 20.0,),
//                                   );
//                                 },
//                               )
//                             ],
//                           ),
//                         )
//                     )
//                   ],
//                 ),
//                 Divider(color: Colors.grey[300],height: 1.0,),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(widget.detail.name,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 19.0),),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10.0),
//                         child: Text("Flutter: Bubble tab indicator for TabBar. Using a Stack Widget and then adding elements to stack on different levels(stacking components like Tabs, above"),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           bottomNavigationBar: Container(
//               margin: EdgeInsets.only(bottom: 18.0),
//               height: 60.0,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border(
//                       top: BorderSide(color: Colors.grey.shade300,width: 1.0)
//                   )
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Container(
//                     child: Row(
//                       children: <Widget>[
//                         Container(
//                           width: 60.0,
//                           child: Text("Total Amount",style: TextStyle(fontSize: 12.0,color: Colors.grey),),
//                         ),
//                         Text("\$${widget.detail.price.toString()}",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w600)),
//                       ],
//                     ),
//                   ),
//                   ScopedModelDescendant<AppModel>(
//                     builder: (context,child,model){
//                       return RaisedButton(
//                         color: Colors.deepOrange,
//                         onPressed: (){
//                           model.addCart(widget.detail);
//                           Timer(Duration(milliseconds: 500), (){
//                             showCartSnak(model.cartMsg,model.success);
//                           });
//                         },
//                         child: Text("ADD TO CART",style: TextStyle(color: Colors.white),),
//                       );
//                     },
//                   )
//                 ],
//               )
//           ),
//         ),
//     );
//   }
// }
