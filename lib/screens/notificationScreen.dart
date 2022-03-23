import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Notiffication"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
          onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: myDrawer(index: 5,),
      body: Text("Hi"),
    );
  }
}