import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:car_washer/bageIcon.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_washer/Helper/request_helper.dart';
import '../Helper/url_helper.dart' as url_helper;

class ProcessingScreen extends StatefulWidget{
  String id;
  ProcessingScreen({required this.id});
  @override
  _ProcessingScreenState createState() => _ProcessingScreenState();
}


class _ProcessingScreenState extends State<ProcessingScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  request_helper requestHelp = new request_helper();

  url_helper.Constants url_help = new url_helper.Constants();

  List<dynamic> list = [];
  Future<void> getPendingData() async {
    Uri url = Uri.parse("${url_help.getAllReguests}${widget.id}");
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};

    await requestHelp.requestGet(url,header).then((responce) async {
      if (responce.statusCode == 200) {
        print(json.decode(responce.body));
        list =  json.decode(responce.body);
        list = list.where((element) => element["request_status"] == "processing").toList();

      }else{
        print("not 200");
      }

    });

  }

  Widget ListHistory(List<dynamic> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return  Container(
          height: MediaQuery.of(context).size.height / 5,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            elevation: 10,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.greenAccent,
            child:Padding(
              padding: EdgeInsets.all(12),
              child:Column(
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
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(onPressed: (){}, child: Text("Finish",style: TextStyle(
                              color: Colors.black
                            ),),  style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              padding: EdgeInsets.all(8)
                            ))
                          ],
                        ),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getPendingData().then((value){
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {

    // print(list);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Processing Requests"),
        centerTitle: true,
        leading: BadgeIcon(scaffoldKey: _scaffoldKey,)
      ),
      drawer: myDrawer(index: 4,),
      body: list.isEmpty?
          Align(
            alignment: Alignment.center,
            child: Text("You Have No Processing Requests"),
          )
      :Padding(
        padding: const EdgeInsets.all(12),
        child: ListHistory(list),
      ),
    );
  }
}