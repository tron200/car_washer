import 'dart:convert';

import 'package:car_washer/bageIcon.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_washer/Helper/request_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../Helper/url_helper.dart' as url_helper;

class PendingScreen extends StatefulWidget{
  String id;
  PendingScreen({required this.id});
  @override
  _PendingScreenState createState() => _PendingScreenState();
}


class _PendingScreenState extends State<PendingScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  request_helper requestHelp = new request_helper();

  url_helper.Constants url_help = new url_helper.Constants();

  List<dynamic> list = [];
  Future<void> getPendingRequests() async {
    Uri url = Uri.parse("${url_help.getAllReguests}${widget.id}");
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};

    await requestHelp.requestGet(url,header).then((responce){
      if (responce.statusCode == 200) {
        print("::::: ${json.decode(responce.body)}");
        setState(() {
          list =  json.decode(responce.body);

        });
        list = list.where((element) => element["request_status"] == "pending").toList();


      }

    });

  }

  Widget ListHistory(List<dynamic> list){
    return ListView.builder(
      itemCount: list.length,
      padding: const EdgeInsets.only(top: 10.0),
      itemBuilder: (BuildContext context,int index){
        return  Container(

          height: MediaQuery.of(context).size.height /5,
          child: Card(

            elevation: 10,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child :Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Booking Id: ${list[index]["booking_id"]}", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,

                        ),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.account_circle_rounded, size: MediaQuery.of(context).size.height / 18,),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: (){}, child: Text("Accept"),style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),),
                        ElevatedButton(onPressed: (){}, child: Text("Cancel"),style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),),

                      ],
                    ),
                  ),
                ],
              ),
              // child: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       mainAxisSize: MainAxisSize.min,
              //
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text("Booking Id: ${list[index]["booking_id"]}", style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 15,
              //             ),),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             Icon(Icons.account_circle_rounded, size: MediaQuery.of(context).size.height / 18,),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(list[index]["user_name"]),
              //                 Text("Service: ${list[index]["service_name"]}", style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 15
              //                 ),)
              //               ],
              //             )
              //           ],
              //         ),
              //
              //       ],
              //     ),
              //     Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             ElevatedButton(onPressed: () async {
              //               Uri uri = Uri.parse(url_help.acceptRequest);
              //               Map<String,dynamic> body = {
              //                 "request_id" : list[index]['id'],
              //               };
              //               await requestHelp.requestPost(uri, body);
              //             }, child: Text("Accept"),style: ElevatedButton.styleFrom(
              //               primary: Colors.green,
              //             ),),
              //             ElevatedButton(onPressed: () async {
              //               Uri uri = Uri.parse(url_help.cancelRequest);
              //               Map<String,dynamic> body = {
              //                 "request_id" : list[index]['id'],
              //               };
              //               await requestHelp.requestPost(uri, body);
              //             }, child: Text("Cancel"),style: ElevatedButton.styleFrom(
              //               primary: Colors.red,
              //             ),),
              //
              //           ],
              //         ),
              //
              //       ],
              //     ),
              //
              //   ],
              // ),
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
    WidgetsFlutterBinding.ensureInitialized();
    getPendingRequests();
  }
  @override
  Widget build(BuildContext context) {

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
        child: list.isEmpty?
        Align(
          alignment: Alignment.center,
          child: Text("You Have No Pending Requests"),
        )
            :ListHistory(list),
      ),
    );
  }
}