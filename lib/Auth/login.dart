import 'dart:convert';
import 'dart:io' show Platform;

import 'package:car_washer/Auth/register.dart';
import 'package:car_washer/Helper/request_helper.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:car_washer/Helper/url_helper.dart' as url_helper;
import 'package:http/http.dart' as http;
class login extends StatefulWidget{
  static String id = 'login_screen';

  @override
  _loginstate createState() => _loginstate();

}



class _loginstate extends State<login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  request_helper request_help = new request_helper();
  url_helper.Constants constants = new url_helper.Constants();

  static Future<bool> getDeviceDetails() async {
    final prefs = await SharedPreferences.getInstance();
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
        await prefs.setString('deviceVersion', "android");
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;  //UUID for iOS
        await prefs.setString('deviceVersion', "ios");
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    await prefs.setString('deviceName', deviceName);
    await prefs.setString('identifier', identifier);
    //if (!mounted) return;
    return true;
  }
  @override
  Widget build(BuildContext context) {
    void click() {
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => register())
        ,);
    }

    Future<void> signin() async {
      //here _emailController.text
      WidgetsFlutterBinding.ensureInitialized();

      final prefs = await SharedPreferences.getInstance();
      // check error waiting
      FirebaseMessaging.instance.getToken().then((token) async {
        getDeviceDetails();

        await prefs.setString('device_token', token!);

        Uri uri = Uri.parse(constants.login);
        Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};
        Map<String, dynamic> body = {
          "grant_type" : "password",
          "client_id"  : constants.client_id  ,
          "client_secret": constants.client_secret,
          "email":_emailController.text,
          "password":_passwordController.text,
          "device_type": prefs.getString("deviceVersion"),
          "device_id":prefs.getString("identifier"),
          "device_token":prefs.getString("deviceVersion")
        };
        request_help.requestPost(uri, header, body).then((response) {
          if(response.statusCode == 200){
            print("Done");
            print(response.body);
          }else if(response.statusCode == 401){
            //show error email or pasword in correct
            print(response.statusCode);
          }else{
            //show error : else if internet connection lost or something error
            print(response.statusCode);

          }
        });

      });

      }
      //http request to https://lamaah.ae/api/provider/oauth/token
    }
    void facebookLogin(){
      // aho yasta
    }

    void googleLogin(){
      // aho tany
    }




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