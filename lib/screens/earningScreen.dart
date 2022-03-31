import 'package:car_washer/bageIcon.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EarningScreen extends StatelessWidget{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: myDrawer(index: 2,),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("My Earning"),
        leading: BadgeIcon(scaffoldKey: _scaffoldKey,),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("0"),
                  Text("0"),
                  Text("0 AED"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Washes"),
                Text("Earning"),
                Text("Commision"),
              ],
            )
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Date"),
                Text("Time"),
                Text("Amount"),
              ],
            )
            ),
          ],
        ),
      ),
    );

  }
}