import 'dart:convert';
import 'dart:io' show Platform;

import 'package:car_washer/Helper/request_helper.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:car_washer/Helper/url_helper.dart' as url_helper;

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
    String identifier="";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        identifier = build.androidId;  //UUID for Android
        await prefs.setString('deviceType', "android");
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        identifier = data.identifierForVendor;  //UUID for iOS
        await prefs.setString('deviceType', "ios");
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
      Navigator.pushNamed(context, 'register');

    }


    Future<UserCredential> signInWithFacebook() async {
      final prefs = await SharedPreferences.getInstance();
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await prefs.setString("access_token", loginResult.accessToken!.token);
      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }

    Future<void> facebookLogin() async {
      WidgetsFlutterBinding.ensureInitialized();
      final prefs = await SharedPreferences.getInstance();
      FirebaseMessaging.instance.getToken().then((Dtoken){
        signInWithFacebook().then((facebookAuthCredential) async {
          await prefs.setString("device_token", Dtoken!);
          await getDeviceDetails();
          //FACEBOOK_signin

          Uri uri = Uri.parse(constants.FACEBOOK_LOGIN);
          Map<String, dynamic> body = {
            "device_type": await  prefs.getString("deviceType"),
            "device_token": Dtoken,
            "access_token": await prefs.getString("accessToken"),
            "device_id": await prefs.getString("identifier"),
            "login_by": "google"
          };

          request_help.requestPost(uri, body).then((response){
            if(response.statusCode == 200){
              print(response.statusCode);
              print(response.body);
            }else{
              print(response.statusCode);
              print(response.body);
            }
          });

        });
      });
    }

    Future<User?> signInWithGoogle({required BuildContext context}) async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;

      if (kIsWeb) {
        GoogleAuthProvider authProvider = GoogleAuthProvider();

        try {
          final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);

          user = userCredential.user;
        } catch (e) {
          print(e);
        }
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn();

        final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

        if (googleSignInAccount != null) {

          await googleSignInAccount.authentication.then((googleSignInAuthentication) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("access_token", googleSignInAuthentication.accessToken!);
            final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            );
            try {
              final UserCredential userCredential =
              await auth.signInWithCredential(credential);

              user = userCredential.user;
            } on FirebaseAuthException catch (e) {
              if (e.code == 'account-exists-with-different-credential') {
                // ...
              } else if (e.code == 'invalid-credential') {
                // ...
              }
            } catch (e) {
              // ...
            }
          });

        }
      }

      return user;
    }

    Future<void> googleLogin() async {
        final prefs = await SharedPreferences.getInstance();
        WidgetsFlutterBinding.ensureInitialized();
        FirebaseMessaging.instance.getToken().then((Dtoken){
        signInWithGoogle(context: context).then((user) async {

            print("gtoken ${await prefs.getString("access_token")}");
            await getDeviceDetails();
            //GOOGLE_LOGIN
            Uri uri = Uri.parse(constants.GOOGLE_LOGIN);
            Map<String, dynamic> body = {
              "device_type": await  prefs.getString("deviceType"),
              "device_token": Dtoken,
              "access_token": await prefs.getString("access_token"),
              "device_id": await prefs.getString("identifier"),
              "login_by": "google"
              };
            print(body);
            request_help.requestPost(uri, body).then((response) async {
              if(response.statusCode == 200){
                print(json.decode(response.body)["access_token"]);
                await prefs.setString("access_token", "${json.decode(response.body)["access_token"]}").then((value){
                Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                });
              }else{
                print(response.statusCode);
                print(response.body);
              }
            });

          });
        });
    }
    Future<void> signin() async {
      //here _emailController.text
      WidgetsFlutterBinding.ensureInitialized();

      final prefs = await SharedPreferences.getInstance();
      // check error waiting
      FirebaseMessaging.instance.getToken().then((token) async {
        await getDeviceDetails();

        await prefs.setString('device_token', token!);

        Uri uri = Uri.parse(constants.login);
        Map<String, dynamic> body = {
          "grant_type" : "password",
          "client_id"  : constants.client_id  ,
          "client_secret": constants.client_secret,
          "email":_emailController.text,
          "scope": "",
          "logged_in": "1",
          "password":_passwordController.text,
          "device_type": await prefs.getString("deviceType"),
          "device_id": await prefs.getString("identifier"),
          "device_token": await prefs.getString("device_token")
        };
        request_help.requestPost(uri, body).then((response) async {
          if(response.statusCode == 200){
            print("Done");
            await prefs.setString("access_token", "${json.decode(response.body)["access_token"]}").then((value){
              Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
            });

          }else if(response.statusCode == 401){
            //show error email or pasword in correct
            print(response.statusCode);
          }else{
            //show error : else if internet connection lost or something error
            print(response.statusCode);
            print(response.body);

          }
        });

      });

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
                            ),
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
                                ),
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
