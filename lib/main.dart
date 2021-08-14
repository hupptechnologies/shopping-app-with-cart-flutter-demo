import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scope_demo/pages/HomePage.dart';

void main(){
  runApp(Main());
}

class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// class Main extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     AppModel appModel = AppModel();
//     // TODO: implement build
//     return ScopedModel<AppModel>(
//       model: appModel,
//       child: MaterialApp(
//         home: Home(appModel: appModel,),
//         // routes: routes,
//         theme: ThemeData(
//             primaryColor: Colors.white
//         ),
//       ),
//     );
//   }
// }


