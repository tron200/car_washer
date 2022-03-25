import 'dart:convert';

import 'package:car_washer/screens/editProfileScreen.dart';
import 'package:car_washer/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'Auth/login.dart';


class Wrapper extends StatefulWidget{
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper>{
  late String? userjson= "";
  String user = "";
  Future<String> getData() async{
    final prefs = await SharedPreferences.getInstance();
    userjson=await prefs.getString("userjson");
    print(json.decode(userjson!));
    return userjson!;


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    getData().then((value){
      setState(() {
        user = value;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("lol ${user}");
    return user == "" ? login(): HomeScreen();
  }
}