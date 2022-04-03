import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../Helper/url_helper.dart' as url_helper;
import 'package:car_washer/Helper/request_helper.dart';
import 'package:geocode/geocode.dart';
import 'package:car_washer/screens/homeScreen.dart';

class chooseLocationScreen extends StatefulWidget{
  String id;
  chooseLocationScreen({required this.id});
  @override
  _chooseLocationScreenState createState() => _chooseLocationScreenState();
}
class _chooseLocationScreenState extends State<chooseLocationScreen>{
  request_helper requestHelp = new request_helper();
  url_helper.Constants url_help = new url_helper.Constants();
  Location location = new Location();
  late LocationData _locationData;

  Future<void> setProviderLocation(LatLng x) async{
    Uri uri = Uri.parse(url_help.setProviderLocation);
    Map<String, dynamic> body= {
      "provider_id": widget.id,
      "latitude": x.latitude,
      "longitude": x.longitude
    };
    requestHelp.requestPost(uri, body).then((response){
      if(response.statusCode == 200){
        print("Done");
      }else{
        print(response.body);
      }
    });
  }


  Future<void> getCurrentLocation() async{
   _locationData = await location.getLocation();
  }
  static double x = 0;
  static double y = 0;
  late LatLng _center = LatLng(x,y);
  late LatLng markedLocation = LatLng(x,y);
  Set<Marker> _markers = {};
  late GoogleMapController mapController;
  GeoCode geoCode = GeoCode();
  late Coordinates coordinates;
  late var addresses;
  var first = "";
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;



  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation().then((value){
      x = _locationData.latitude!;
      y = _locationData.longitude!;
      print("x: $x y: $y");
      setState(() {
        _center = LatLng(x, y);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: _center == LatLng(0,0)?Container():GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            padding: EdgeInsets.only(top: 50),
            onTap: (click) async{
              print("CLICKED");
              setState(() {
                markedLocation = click;
                print(markedLocation);

                _markers
                    .add(Marker(markerId: MarkerId('id-1'), position: markedLocation));
              });
              addresses = (await geoCode.reverseGeocoding(latitude: markedLocation.latitude, longitude: markedLocation.longitude));

            setState(() {
              first = "${addresses.streetAddress == null? "":addresses.streetAddress}, ${addresses.region}, ${addresses.countryName == null?"":addresses.countryName}";

            });
            },
          ),

        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            height: 200,
            duration: new Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,

            child: Card(
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Align(alignment: Alignment.center,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Choose Your Location", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent

                        ),),
                      ),)),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xffEAEEF6)
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(child: Icon(Icons.location_on,color: Colors.red,)),
                                TextSpan(text: first, style: TextStyle(
                                  color: Colors.black,

                                ))
                              ]
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(onPressed: (){
                    markedLocation != LatLng(0,0)?
                    setProviderLocation(markedLocation).then((value){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()),  (route) => false);
                    }): null;
                  }, child: Text("Done"))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}