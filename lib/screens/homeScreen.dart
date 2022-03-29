import 'package:car_washer/Helper/request_helper.dart';
import 'package:car_washer/myDrawer.dart';
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
  String title = "Offline";
  static double lat = 28.47212100;
  static double lon = 77.07251060;
  bool value_switch = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List userData =[];

  late GoogleMapController mapController;

   final LatLng _center =  LatLng(lat, lon);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  request_helper requestHelp = new request_helper();
  url_helper.Constants url_help = new url_helper.Constants();

  Future<void> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(url_help.USER_PROFILE_API);
    var token = await prefs.getString("access_token");
    Map<String, String> header = {
      "X-Requested-With": "XMLHttpRequest",
      "Authorization": "Bearer $token"} ;

    requestHelp.requestGet(url,header).then((responce) async {
      if(responce.statusCode == 200) {
        final String? user = responce.body;
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
  }
  @override
  Widget build(BuildContext context) {
    Color blue800 = Colors.blue.shade800;
    return Scaffold(
        key: _scaffoldKey,
        drawer: myDrawer(index: 0,),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,


                ),

              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        height: 15.0.h,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: IconButton(
                            icon: Icon(Icons.menu, color: Colors.white,),
                            onPressed: (){
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          )

                        ),
                      ),
                      Container( // Background
                        child: Text(title, style: TextStyle(fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),),


                      ),
                      Container(
                        height: 15.0.h,
                        child: Switch(
                          value: value_switch,
                          onChanged: (bool? value){
                            setState(() {
                              value_switch = value!;
                              value_switch? title = "Online": title= "Offline";
                            });
                          },
                          activeColor: Colors.blue,
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

