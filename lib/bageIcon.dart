import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import './globals.dart' as globals;
class BadgeIcon extends StatefulWidget{
  GlobalKey<ScaffoldState> scaffoldKey;
  BadgeIcon({required this.scaffoldKey});
  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<BadgeIcon>{
  int text = globals.text;
  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 5), () {

// Here you can write your code
      text == 1? null:
      setState(() {
        // Here you can write your code for open new view
        text = globals.text;
      });

    });
    return  Badge(

      animationType: BadgeAnimationType.slide,
      child: IconButton(
        onPressed: (){
          widget.scaffoldKey.currentState?.openDrawer();
        },
        icon: Icon(Icons.menu, color: Colors.black,),
      ),
      showBadge: text == 0 ?false: true,
      position: BadgePosition.topEnd(top: 10, end: 10,),
      padding: EdgeInsets.all(6),
      elevation: 10,
    );
  }
}