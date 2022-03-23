import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SummaryScreen extends StatelessWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Summary"),
        leading:  IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
          onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      drawer: myDrawer(index: 4,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("TOTAL RIDES",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),),
            SizedBox(height: 2.2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("0",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),),
            ),
            SizedBox(height: 10.0.h,),

            Text("REVENUE",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),),
            SizedBox(height: 2.2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("\$ 0",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),),
            ),
            SizedBox(height: 10.0.h,),
            Text("SCHEDULED WASHES",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),),
            SizedBox(height: 2.2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("0",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),),
            ),
            SizedBox(height: 10.0.h,),
            Text("CANCELLED WASHES",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),),
            SizedBox(height: 2.2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("0",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),),
            )
          ],
        ),
      ),
    );
  }

}