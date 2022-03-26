import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: myDrawer(index: 1),
          appBar: AppBar(
            backgroundColor: Colors.blue.shade800,
            title: Text("Hisory"),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white,),
              onPressed: (){
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('PAST WASHES'),
                ),
                Tab(
                  child: Text('UPCOMING WASHES'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PastRidesTap(),
              UpcomingRidesTap()
            ],
          )
      )
    );
  }
}


class PastRidesTap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("data");
  }

}


class UpcomingRidesTap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("data 2");
  }

}