import 'dart:convert';

import 'package:car_washer/bageIcon.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:car_washer/Helper/request_helper.dart';
import '../Helper/url_helper.dart' as url_helper;

class HistoryScreen extends StatefulWidget{
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}


class _HistoryScreenState extends State<HistoryScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  request_helper requestHelp = new request_helper();

  url_helper.Constants url_help = new url_helper.Constants();
  List<dynamic> complete = [];
  List<dynamic> cancelled = [];
  List<dynamic> scheduled = [];
  List<dynamic> requests = [];


  Future<dynamic> getAllRequests() async {
    Uri url = Uri.parse("${url_help.getAllReguests}2");
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};

    await requestHelp.requestGet(url,header).then((responce) async {
      if (responce.statusCode == 200) {
        // print(json.decode(responce.body));
        requests =  json.decode(responce.body)["requests"];
        setState(() {
          complete = requests.where((element) => element["request_status"] == "complete").toList();
          cancelled = requests.where((element) => element["request_status"] == "complete").toList();
          scheduled = requests.where((element) => element["request_status"] == "complete").toList();
        });


      }

    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRequests();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 3,

        child: Scaffold(
          key: _scaffoldKey,
          drawer: myDrawer(index: 1),
          appBar: AppBar(
            backgroundColor: Colors.blue.shade800,
            title: Text("Washes History"),
            centerTitle: true,
            leading: BadgeIcon(scaffoldKey: _scaffoldKey,),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('Past'),
                ),
                Tab(
                  child: Text('Cancelled'),
                ),
                Tab(
                  child: Text('Scheduled'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PastRidesTap(list: complete),
              CancelledRidesTap(list: cancelled),
              ScheduledRidesTap(list: scheduled)
            ],
          )
      )
    );
  }
}
class PastRidesTap extends StatefulWidget{
  List<dynamic> list;
  PastRidesTap({required this.list});
  @override
  _PastRidesTapState createState() => _PastRidesTapState();
}

class _PastRidesTapState extends State<PastRidesTap>{
  int current = 0;





  Widget ListHistory(List<dynamic> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return  Container(
          height: MediaQuery.of(context).size.height / 6,
          child: FlipCard(

                  direction: FlipDirection.HORIZONTAL,
                  speed: 1000,
                  onFlip: (){
                  },
                  front: Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  elevation: 10,

                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.greenAccent,
                  child:Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            Icon(Icons.account_circle_rounded, size: MediaQuery.of(context).size.height / 18,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mohammed"),
                                Text("Total: 12 AED", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),)
                              ],
                            )
                          ],
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Text("Date: ", style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${list[index]["created_at"]}".split(" ")[0], style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                  ),
                  back: Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  elevation: 10,

                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.greenAccent,
                  child:
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Text("Payment Type: 0", style: TextStyle(
                          fontSize: 15,
                        ),),
                        Text("Tax: 0 AED", style: TextStyle(
                          fontSize: 15,
                        ),),
                        Text("Commision: 0 AED", style: TextStyle(
                          fontSize: 15,
                        ),),
                        Text("Total: 0 AED", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),)

                      ],
                    ),
                  ),),
                ),
        );


      },
    );
  }


  // List<dynamic> list = [
  //   {
  //     "id": "IL4EF5",
  //     "car_name": "Fiat 128",
  //     "rating": "5.00",
  //     "date": "13-12-2000",
  //     "comment": "Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service  ",
  //     "payment_type": "Cash",
  //     "tax": "5.00",
  //     "commission": " 13.00",
  //     "total": "12"
  //   },
  //   {
  //     "id": "ILE7UI",
  //     "car_name": "Fiat Tipo",
  //     "rating": "4.00",
  //     "date": "14-08-1999",
  //     "comment": "Very Good Service",
  //     "payment_type": "Cash",
  //     "tax": "5.00",
  //     "commission": " 13.00",
  //     "total": "12"
  //
  //   },
  //   {
  //     "id": "ILE7UI",
  //     "car_name": "Fiat Tipo",
  //     "rating": "3.5",
  //     "date": "14-08-1999",
  //     "comment": "Very Good Service",
  //     "payment_type": "Cash",
  //     "tax": "5.00",
  //     "commission": " 13.00",
  //     "total": "12"
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
          padding: EdgeInsets.all(12),
          child:  widget.list.isEmpty?
          Align(
            alignment: Alignment.center,
            child: Text("You Have No Past Requests"),
          )
              :ListHistory(widget.list),

        );


  }

}



class CancelledRidesTap extends StatelessWidget{
  List<dynamic> list;
  CancelledRidesTap({required this.list});

  Widget ListHistory(List<dynamic> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return  Container(
          height: MediaQuery.of(context).size.height / 6,
          child: FlipCard(

            direction: FlipDirection.HORIZONTAL,
            speed: 1000,
            onFlip: (){
            },
            front: Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 10,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.greenAccent,
              child:Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        Icon(Icons.account_circle_rounded, size: MediaQuery.of(context).size.height / 18,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammed"),
                            Text("Total: 12 AED", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),)
                          ],
                        )
                      ],
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text("Date: ", style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            Text("${list[index]["created_at"]}".split(" ")[0], style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
            back: Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 10,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.greenAccent,
              child:
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Text("Payment Type: 0", style: TextStyle(
                      fontSize: 15,
                    ),),
                    Text("Tax: 0 AED", style: TextStyle(
                      fontSize: 15,
                    ),),
                    Text("Commision: 0 AED", style: TextStyle(
                      fontSize: 15,
                    ),),
                    Text("Total: 0 AED", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),)

                  ],
                ),
              ),),
          ),
        );


      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(12),
      child:  list.isEmpty?
      Align(
        alignment: Alignment.center,
        child: Text("You Have No Cancelled Requests"),
      )
          :ListHistory(list),

    );
  }

}
class ScheduledRidesTap extends StatelessWidget{
  List<dynamic> list;
  ScheduledRidesTap({required this.list});
  Widget ListHistory(List<dynamic> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return  Container(
          height: MediaQuery.of(context).size.height / 6,
          child: FlipCard(

            direction: FlipDirection.HORIZONTAL,
            speed: 1000,
            onFlip: (){
            },
            front: Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 10,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.greenAccent,
              child:Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        Icon(Icons.account_circle_rounded, size: MediaQuery.of(context).size.height / 18,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammed"),
                            Text("Total: 12 AED", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),)
                          ],
                        )
                      ],
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text("Date: ", style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            Text("${list[index]["created_at"]}".split(" ")[0], style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
            back: Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 10,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.greenAccent,
              child:
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Text("Payment Type: 0", style: TextStyle(
                      fontSize: 15,
                    ),),
                    Text("Tax: 0 AED", style: TextStyle(
                      fontSize: 15,
                    ),),
                    Text("Commision: 0 AED", style: TextStyle(
                      fontSize: 15,
                    ),),
                    Text("Total: 0 AED", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),)

                  ],
                ),
              ),),
          ),
        );


      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(12),
      child:  list.isEmpty?
      Align(
        alignment: Alignment.center,
        child: Text("You Have No Scheduled Requests"),
      )
          :ListHistory(list),

    );
  }

}


