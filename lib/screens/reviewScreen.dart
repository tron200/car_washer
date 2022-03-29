import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../rating.dart';


class ReviewScreen extends StatefulWidget{
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget ListHistory(List<dynamic> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.account_circle_rounded, size: 60,),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Rating(value: double.parse(list[index]["rating"])),
                        ),
                      ],
                    ),
                    Text("Mohammed", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),),
                    Text("Date: ${list[index]["date"]}", style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),)
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
                child: ReadMoreText(
                      "Comment: ${list[index]["comment"]}",
                      key: UniqueKey(),
                      trimLines: 4,
                      colorClickableText: Colors.blue.shade800,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Review"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child:  ListHistory(list),

      ),
    );
  }
}