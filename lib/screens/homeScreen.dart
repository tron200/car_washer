import 'dart:convert';

import 'package:car_washer/Helper/request_helper.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Helper/url_helper.dart' as url_helper;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  String title = "Offline";
  bool value_switch = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String,dynamic> userData ={"":""};

  request_helper requestHelp = new request_helper();
  url_helper.Constants url_help = new url_helper.Constants();
  Future<void> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    FirebaseMessaging.instance.getToken().then((token) async {
    Uri url = Uri.parse(url_help.USER_PROFILE_API);
    var token = await prefs.getString("device_token");
    print(token);
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Bearer ${token!}");
    requestHelp.requestGet(url,header).then((responce) async {
      if(responce.statusCode == 200) {
        final String? user = responce.body;
        print(user);
        final data = await json.decode(user!);
        userData = data;
      }else{
        print(responce.statusCode);
      }
    });

      });


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }
  @override
  Widget build(BuildContext context) {
    Color blue800 = Colors.blue.shade800;
    return Scaffold(
        key: _scaffoldKey,
        drawer: myDrawer(index: 0,),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:

          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: Image.network("https://m.media-amazon.com/images/I/91cM19R8NeL._AC_SL1500_.jpg",fit: BoxFit.fill),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        height: 15.0.h,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: IconButton(
                            icon: Icon(Icons.menu, color: Colors.white,),
                            onPressed: (){
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          )

                        ),
                      ),
                      Container( // Background
                        child: Text(title, style: TextStyle(fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),),


                      ),
                      Container(
                        height: 15.0.h,
                        child: Switch(
                          value: value_switch,
                          onChanged: (bool? value){
                            setState(() {
                              value_switch = value!;
                              value_switch? title = "Online": title= "Offline";
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.all(12),
                    color: blue800,
                    height: 15.0.h,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // SizedBox(height: 2.0.h,),
                            Icon(Icons.restore,size:50,color: Colors.white,),
                            Text("0", style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),),
                            Text("Washes", style: TextStyle(
                                fontSize: 15,
                                color: Colors.white
                            ),),

                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.bar_chart,size: 50,color: Colors.white,),
                            Text("0", style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),),
                            Text("Earnings", style: TextStyle(
                                fontSize: 15,
                                color: Colors.white
                            ),),

                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.attach_money_sharp,size: 50,color: Colors.white,),
                            Text("0", style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),),
                            Text("Commision", style: TextStyle(
                                fontSize: 15,
                                color: Colors.white
                            ),),

                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],

          ),




        ),
    );
  }


}

