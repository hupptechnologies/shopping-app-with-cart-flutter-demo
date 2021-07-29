import 'package:flutter/material.dart';
import 'package:scope_demo/Cart.dart';
import 'package:scope_demo/Details.dart';
import 'package:scope_demo/Home.dart';
import 'package:scope_demo/ScopeManage.dart';
import 'package:scoped_model/scoped_model.dart';

void main(){
  runApp(Main());
}

class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AppModel appModel = AppModel();
    // TODO: implement build
    return ScopedModel<AppModel>(
      model: appModel,
      child: MaterialApp(
        home: Home(appModel: appModel,),
        // routes: routes,
        theme: ThemeData(
            primaryColor: Colors.white
        ),
      ),
    );
  }
}


