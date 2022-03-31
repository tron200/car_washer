import 'package:car_washer/bageIcon.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:readmore/readmore.dart';

import '../rating.dart';

class HistoryScreen extends StatelessWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 4,

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
                  child: Text('Upcoming'),
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
              PastRidesTap(),
              UpcomingRidesTap(),
              CancelledRidesTap(),
              ScheduledRidesTap()
            ],
          )
      )
    );
  }
}
class PastRidesTap extends StatefulWidget{
  @override
  _PastRidesTapState createState() => _PastRidesTapState();
}

class _PastRidesTapState extends State<PastRidesTap>{
  int current = 0;

  int _line = 2;
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
                    setState(() {});
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
                            Text("Booking Id: ${list[index]["id"]}", style: TextStyle(
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
                          child: Text("Date: ${list[index]["date"]}", style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),)
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


                        Text("Payment Type: ${list[index]["payment_type"]}", style: TextStyle(
                          fontSize: 15,
                        ),),
                        Text("Tax: ${list[index]["tax"]} AED", style: TextStyle(
                          fontSize: 15,
                        ),),
                        Text("Commision: ${list[index]["commission"]} AED", style: TextStyle(
                          fontSize: 15,
                        ),),
                        Text("Total: ${list[index]["total"]} AED", style: TextStyle(
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


  List<dynamic> list = [
    {
      "id": "IL4EF5",
      "car_name": "Fiat 128",
      "rating": "5.00",
      "date": "13-12-2000",
      "comment": "Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service Very Good Service  ",
      "payment_type": "Cash",
      "tax": "5.00",
      "commission": " 13.00",
      "total": "12"
    },
    {
      "id": "ILE7UI",
      "car_name": "Fiat Tipo",
      "rating": "4.00",
      "date": "14-08-1999",
      "comment": "Very Good Service",
      "payment_type": "Cash",
      "tax": "5.00",
      "commission": " 13.00",
      "total": "12"

    },
    {
      "id": "ILE7UI",
      "car_name": "Fiat Tipo",
      "rating": "3.5",
      "date": "14-08-1999",
      "comment": "Very Good Service",
      "payment_type": "Cash",
      "tax": "5.00",
      "commission": " 13.00",
      "total": "12"
    },
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
          padding: EdgeInsets.all(12),
          child:  ListHistory(list),

        );


  }

}


class UpcomingRidesTap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("data 2");
  }

}

class CancelledRidesTap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("data");
  }

}
class ScheduledRidesTap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("data");
  }

}


