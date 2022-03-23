import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class myDrawer extends StatefulWidget {
  int index;
  myDrawer ({Key? key , required this.index}) : super(key: key);

  @override
  _myDrawerState createState() => _myDrawerState();

}

class _myDrawerState extends State<myDrawer> {
  List<bool> isSelected = List<bool>.filled(9, false);
  String dropdownvalue = 'En';

  Map<String,dynamic> userData ={"":""};

  // List of items in our dropdown menu
  var items = [
    'En',
    'Ar',
  ];
  @override
  Future<void> setupUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userData = await ( json.decode(await prefs.getString("user")!));
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupUserData();

  }
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    isSelected[widget.index] = true;
    // TODO: implement build
    return Drawer(
      child: ListView(
// Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
            ),
            child: Container(
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pushNamed(context, 'profile');
                      }, icon: Icon(Icons.account_circle_rounded,),iconSize: 100,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.5.h,),

                          RichText(

                            text: TextSpan(
                              children: [

                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Icons.star, size: 15, color: Colors.yellowAccent,),
                                  ),
                                ),
                                TextSpan(text: '5.0'),
                              ],

                            ),
                          ),
                          SizedBox(height: 1.2.h,),
                          Text("Approved", style: TextStyle(
                            color: Colors.green.shade500,
                            fontSize: 15,

                            fontWeight: FontWeight.bold

                          ))
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("${userData['first_name']}" ,style: TextStyle(
                      fontSize: 18,

                    ),),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              isSelected[0]? Navigator.pop(context):
              Navigator.pushReplacementNamed(context, 'home');
            },
            selected: isSelected[0],
          ),
          ListTile(
            title: const Text('History'),
            onTap: () {
              isSelected[1]? Navigator.pop(context):
              Navigator.pushReplacementNamed(context, 'history');
            },
            selected: isSelected[1],
          ),
          ListTile(
            title: const Text('My Earning'),
            onTap: () {
              isSelected[2]? Navigator.pop(context):
              Navigator.pushReplacementNamed(context, 'earning');
            },
            selected: isSelected[2],
          ),
          ListTile(
            title: const Text('Documents'),
            onTap: () {
// Update the state of the app.
// ...
              isSelected[3]? Navigator.pop(context):
              Navigator.pushReplacementNamed(context, 'document');

            },
            selected: isSelected[3],
          ),
          ListTile(
            title: const Text('Summary'),
            onTap: () {
              isSelected[4]? Navigator.pop(context):
              Navigator.pushReplacementNamed(context, 'summary');
            },
            selected: isSelected[4],
          ),
          ListTile(
            title: const Text('Notification'),
            onTap: () {
              isSelected[5]? Navigator.pop(context):
              Navigator.pushReplacementNamed(context, 'notification');
            },
            selected: isSelected[5],
          ),
          ListTile(
            title: const Text('Withdraw'),
            onTap: () {
              isSelected[6]? Navigator.pop(context):
              Navigator.pushReplacementNamed(context, 'withdraw');
            },
            selected: isSelected[6],
          ),
          ListTile(
            title: const Text('Help'),
            onTap: () {
              isSelected[7]? Navigator.pop(context):
              Navigator.pushReplacementNamed(context, 'help');
            },
            selected: isSelected[7],
          ),
          ListTile(
            title: const Text('Change Language'),
            onTap: null,
            trailing: DropdownButton(

              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),

        ],
      ),
    );

  }
}
