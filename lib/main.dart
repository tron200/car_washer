import 'package:car_washer/screens/documentsScreen.dart';
import 'package:car_washer/screens/earningScreen.dart';
import 'package:car_washer/screens/editProfileScreen.dart';
import 'package:car_washer/screens/editScreen.dart';
import 'package:car_washer/screens/helpScreen.dart';
import 'package:car_washer/screens/historyScreen.dart';
import 'package:car_washer/screens/homeScreen.dart';
import 'package:car_washer/screens/notificationScreen.dart';
import 'package:car_washer/screens/profileScreen.dart';
import 'package:car_washer/screens/reviewScreen.dart';
import 'package:car_washer/screens/summaryScreen.dart';
import 'package:car_washer/screens/withdrawScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:car_washer/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/login.dart';
import 'package:sizer/sizer.dart';
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        title: 'Car Washer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: login(),

        routes: {
          'login' : (context) => login(),
          'register': (context) => register(),
          'home': (context) => HomeScreen(),
          'document': (context) => DocumentScreen(),
          'profile': (context) => ProfileScreen(),
          'editprofile': (context) => EditProfileScreen(),
          'summary': (context) => SummaryScreen(),
          'earning': (context) => EarningScreen(),
          'withdraw': (context) => WithdrawScreen(),
          'history': (context) => HistoryScreen(),
          'notification': (context) => NotificationScreen(),
          'help': (context) => HelpScreen(),
          'review': (context) => ReviewScreen(),
          'edit': (context) => EditScreen(name: "sdv", Editingvalue: "dsv"),
        },

      );
    });
  }
}

