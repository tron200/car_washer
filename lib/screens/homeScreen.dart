import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  String title = "Offline";
  bool value_switch = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

