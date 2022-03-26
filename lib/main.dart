import 'package:car_washer/Auth/otpVerfication.dart';
import 'package:car_washer/screens/documentsScreen.dart';
import 'package:car_washer/screens/earningScreen.dart';
import 'package:car_washer/screens/helpScreen.dart';
import 'package:car_washer/screens/historyScreen.dart';
import 'package:car_washer/screens/homeScreen.dart';
import 'package:car_washer/screens/notificationScreen.dart';
import 'package:car_washer/screens/reviewScreen.dart';
import 'package:car_washer/screens/summaryScreen.dart';
import 'package:car_washer/screens/withdrawScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:car_washer/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/login.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'screens/addAcountScreen.dart';
import 'wrapper.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
  configLoading();
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
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
          'document': (context) => DocumentScreen(),
          'summary': (context) => SummaryScreen(),
          'earning': (context) => EarningScreen(),
          'withdraw': (context) => WithdrawScreen(),
          'history': (context) => HistoryScreen(),
          'notification': (context) => NotificationScreen(),
          'help': (context) => HelpScreen(),
          'review': (context) => ReviewScreen(),
          'otp': (context) => otpVerfication(),
          'addaccount': (context) => AddAccountScreen(),
        },

      );
    });
  }
}

