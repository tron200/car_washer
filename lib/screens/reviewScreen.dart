import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Review"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Text("Hi"),
    );
  }
}