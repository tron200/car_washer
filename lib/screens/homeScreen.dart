import 'dart:convert';

import 'package:car_washer/Helper/request_helper.dart';
import 'package:car_washer/bageIcon.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Helper/url_helper.dart' as url_helper;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  //latitude,  longitude
  static Map<String, dynamic> userDauserta = {"":""};
  String title = "";
  static double lat = 0;
  static double lon = 0;
  bool value_switch = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List userData =[];
  List<dynamic> Locations = [];
  late GoogleMapController mapController;

  LatLng _center = LatLng(lat, lon);
  static double x = 0;
  static double y = 0;
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    x = double.parse(Locations[0]["latitude"]);
    y = double.parse(Locations[0]["longitude"]);
    print("Location: ${LatLng(x,y)}");

    Locations.forEach((element) {
      x = double.parse(element["latitude"]);
      y = double.parse(element["longitude"]);
      print("Location: ${LatLng(x,y)}");
      setState(() {

        _markers.add(
            Marker(markerId: MarkerId('id-${element["id"]}'), position: LatLng(x,y),infoWindow: InfoWindow(
              title: "${element["first_name"]}"
            ))
        );
      });
    });
  }

  request_helper requestHelp = new request_helper();
  url_helper.Constants url_help = new url_helper.Constants();


  Future<void> getLocations() async{
    Uri uri = Uri.parse("${url_help.getProvidersLocations}275");
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};

    requestHelp.requestGet(uri, header).then((response){
      if(response.statusCode == 200){
        setState(() {
          Locations = json.decode(response.body);
          // print(Locations);
        });
      }
    });
  }

  Future<void> setStatus(String Status) async{
    Uri uri = Uri.parse(url_help.setStatus);
    Map <String, dynamic> body = {
      "provider_id": userDauserta["id"],
      "service_status": Status
    };
    requestHelp.requestPost(uri, body).then((response){
      if(response.statusCode == 200){
        print("Done");
      }else{
        print(response.statusCode);
      }
    });
  }

  Future<void> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    print(await prefs.getString("access_token"));
    Uri url = Uri.parse(url_help.USER_PROFILE_API);
    var token = await prefs.getString("access_token");
    Map<String, String> header = {
      "X-Requested-With": "XMLHttpRequest",
      "Authorization": "Bearer $token"} ;

    requestHelp.requestGet(url,header).then((responce) async {
      if(responce.statusCode == 200) {
        final String? user = responce.body;
        setState(() {
          userDauserta = json.decode(user!);
          // print(userDauserta);
          setState(() {
            lat = double.parse(userDauserta["latitude"]);
            lon = double.parse(userDauserta["longitude"]);
            _center =  LatLng(lat, lon);
            title = userDauserta["service_status"] == "active"?"Online": "Offline";
            value_switch = (title == "Online")? true: false;

          });
          
        });
        await prefs.setString("userjson", user!);
      }else{
        print(responce.statusCode);
      }
    });




  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProfileData();
    getLocations();

  }
  @override
  Widget build(BuildContext context) {
    Color blue800 = Colors.blue.shade800;
    Locations.isEmpty?null:print("Id : ${Locations[0]["id"]}");
    return Scaffold(
        key: _scaffoldKey,
        drawer: myDrawer(index: 0,),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              _center.latitude == 0? Container():
              Container(
                height: MediaQuery.of(context).size.height,
                child:  Locations.isEmpty?Container():GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  padding: EdgeInsets.only(top: 10.0.h ,bottom: MediaQuery.of(context).size.height / 6.4),
                  markers: _markers,
                  onTap: (click){
                    print(click);
                  },
                ),

              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        child: BadgeIcon(scaffoldKey: _scaffoldKey,),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      Container( // Background
                        child: Text(title, style: TextStyle(fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            color: title == "Offline"?Colors.red:Colors.green),),


                      ),
                      Container(
                        height: 15.0.h,
                        child: Switch(
                          value: value_switch,
                          onChanged: (bool? value){
                            setState(() {
                              value_switch = value!;
                              setStatus(title == "Online"? "offline": "active").then((response){
                                title = value_switch? "Online": "Offline";
                                print(title);
                              });
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: blue800
                        ),
                        height: 15.0.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // SizedBox(height: 2.0.h,),
                                Icon(Icons.restore,size:5.0.h,color: Colors.white,),
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
                                Icon(Icons.bar_chart,size: 5.0.h,color: Colors.white,),
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
                                Icon(Icons.attach_money_sharp,size: 5.0.h,color: Colors.white,),
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
                      ),
                    )
                  )
                ],
              )
            ],

          ),




        ),
    );
  }


}

