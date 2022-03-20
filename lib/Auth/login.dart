import 'dart:io' show Platform;

import 'package:car_washer/Auth/register.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class login extends StatefulWidget{
  static String id = 'login_screen';

  @override
  _loginstate createState() => _loginstate();

}



class _loginstate extends State<login> {

  static Future<List<String>> getDeviceDetails() async {
    String deviceName="";
    String deviceVersion="";
    String identifier="";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;  //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    //if (!mounted) return;
    return [deviceName, deviceVersion, identifier];
  }
  @override
  Widget build(BuildContext context) {
    void click() {
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => register())
        ,);
    }

    void signin(){
      //here _emailController.text
      WidgetsFlutterBinding.ensureInitialized();
      FirebaseMessaging.instance.getToken().then((token){
        print("token $token");
        //save token in shared prefrence
        getDeviceDetails().then((resultat){
          List yourlist =[];
          setState(() =>  yourlist.add(resultat));
          print(yourlist);
          //save device data in shared prefrence
          });

      });

      //http request to https://lamaah.ae/api/provider/oauth/token
    }
    void facebookLogin(){
      // aho yasta
    }

    void googleLogin(){
      // aho tany
    }

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,


                        children: [

                          SizedBox(height: 35.0.h,),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 7.5.h,
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  labelText: "Email Address",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  )
                              ),

                            ),
                          ),
                          SizedBox(height: 1.2.h,),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 7.5.h,
                            child:  TextField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  )
                              ),
                            ),
                          ),

                          SizedBox(height: 2.0.h,),

                          GestureDetector(
                            child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    color: Color(0xff3fbcef)
                                ),
                                child: TextButton(
                                  onPressed: signin,
                                  child: Text('Login', style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20

                                  ),),

                                )
                            ),
                          ),
                          SizedBox(height: 1.0.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: click,
                                child: const Text("Forget Password",
                                  style: TextStyle(
                                      color: Color(0xff3fbcef)
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(

                            children: [
                              Expanded(child: Column(
                                children: [

                                  Divider(color: Colors.black,
                                    thickness: 1,
                                    height: 0.5.h,)


                                ],
                              )),

                              Text("  or  "),
                              Expanded(child: Column(
                                children: [

                                  Divider(color: Colors.black,
                                    thickness: 1,
                                    height: 0.5.h,)


                                ],
                              )),
                            ],

                          ),
                          SizedBox(height: 2.5.h,),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  color: Color(0xff3fbcef)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: TextButton(
                                  onPressed: facebookLogin,
                                  child: Text('Login with Facebook',
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              )
                            )

                            ),
                          SizedBox(height: 1.2.h,),
                          GestureDetector(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                      color: Colors.red
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: TextButton(
                                      onPressed: googleLogin,
                                      child: Text('Login with Google',
                                        style: TextStyle(color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  )
                              )

                          ),

                          Row(
                            children: [
                              Text("You don't have an account?",style: TextStyle(color: Colors.black),),
                              TextButton(
                                onPressed: click,
                                child: const Text("Register",
                                  style: TextStyle(
                                      color: Color(0xff3fbcef)
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        )

    );

  }
}