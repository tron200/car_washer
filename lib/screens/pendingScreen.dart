import 'dart:convert';

import 'package:car_washer/bageIcon.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_washer/Helper/request_helper.dart';
import '../Helper/url_helper.dart' as url_helper;

class PendingScreen extends StatefulWidget{

  @override
  _PendingScreenState createState() => _PendingScreenState();
}


class _PendingScreenState extends State<PendingScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  request_helper requestHelp = new request_helper();

  url_helper.Constants url_help = new url_helper.Constants();

  List<dynamic> list = [];
  Future<void> getProfileData() async {
    Uri url = Uri.parse("${url_help.getAllReguests}2");
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};

    await requestHelp.requestGet(url,header).then((responce) async {
      if (responce.statusCode == 200) {
        // print(json.decode(responce.body));
        list =  json.decode(responce.body)["requests"];
        list = list.where((element) => element["request_status"] == "pending").toList();

      }

    });

  }

  Widget ListHistory(List<dynamic> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return  Container(
          height: MediaQuery.of(context).size.height / 6,
          child: Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 10,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.greenAccent,
              child:Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Booking Id: ${list[index]["booking_id"]}", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.account_circle_rounded, size: 60,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(list[index]["user_name"]),
                                Text("Service: ${list[index]["service_name"]}", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),)
                              ],
                            )
                          ],
                        ),

                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(onPressed: (){}, child: Text("Accept"),style: ElevatedButton.styleFrom(
                                  primary: Colors.green
                              ),),
                              ElevatedButton(onPressed: (){}, child: Text("Cancel"),style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),),

                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

        );


      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getProfileData().then((value){
      setState(() {
        // print(value);
        setState(() {});
      });
    });
    // print(list);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Pending Requests"),
        centerTitle: true,
        leading: BadgeIcon(scaffoldKey: _scaffoldKey,)
      ),
      drawer: myDrawer(index: 3,),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListHistory(list),
      ),
    );
  }
}