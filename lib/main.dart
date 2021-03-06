import 'package:car_washer/Auth/otpVerfication.dart';
import 'package:car_washer/chooseLocationScreen.dart';
import 'package:car_washer/screens/documentsScreen.dart';
import 'package:car_washer/screens/earningScreen.dart';
import 'package:car_washer/screens/helpScreen.dart';
import 'package:car_washer/screens/historyScreen.dart';
import 'package:car_washer/screens/homeScreen.dart';
import 'package:car_washer/screens/notificationScreen.dart';
import 'package:car_washer/screens/reviewScreen.dart';
import 'package:car_washer/screens/servicesScreen.dart';
import 'package:car_washer/screens/summaryScreen.dart';
import 'package:car_washer/screens/withdrawScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:car_washer/Auth/register.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/login.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'screens/addAcountScreen.dart';
import 'screens/pendingScreen.dart';
import 'screens/processingScreen.dart';
import 'wrapper.dart';
import 'package:car_washer/globals.dart' as globals;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.getToken().then((Dtoken){
    print(Dtoken);
  });
  runApp(const MyApp());
  configLoading();
}


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..animationDuration = const Duration(milliseconds: 500)
    // ..progressColor = Colors.yellow
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.blue
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        title: 'Car Washer',
        builder: EasyLoading.init(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),

        routes: {
          'login' : (context) => login(),
          'register': (context) => register(),
          'home': (context) => HomeScreen(),
          'summary': (context) => SummaryScreen(),
          'earning': (context) => EarningScreen(),
          'withdraw': (context) => WithdrawScreen(),
          'notification': (context) => NotificationScreen(),
          'help': (context) => HelpScreen(),
          'review': (context) => ReviewScreen(),
          'addaccount': (context) => AddAccountScreen(),
        },

      );
    });
  }
}

