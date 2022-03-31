import 'dart:convert';

import 'package:car_washer/screens/editProfileScreen.dart';
import 'package:car_washer/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
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
    // print(json.decode(userjson!));
    return userjson!;


  }

  Future<void> getpermission() async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    getpermission();
    getData().then((value){
      setState(() {
        user = value;
      });
    });

  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return user == "" ? login(): HomeScreen();
  }
}