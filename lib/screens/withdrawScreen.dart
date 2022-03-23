import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WithdrawScreen extends StatelessWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: myDrawer(index: 6,),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Earned Money"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
          onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Container(
                  child: Row(
                    children: [
                      Text("Available Fund:  ",style: TextStyle(
                          fontSize: 18
                      ),),
                      Text("\$ 0",style: TextStyle(
                          fontSize: 18,
                        color: Colors.red.shade800
                      ),),
                    ],
                  ),

                ),

                ElevatedButton(
                    child: Text("Withdraw"),
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade800
                    ),
                  ),
              ]
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 2,
                    height: 18,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text("Past Withdraw",style: TextStyle(
                  fontSize: 20
                ),)
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width - 24,
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("AMOUNT"),
                      Text("DATE"),
                      Text("STATUS"),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}