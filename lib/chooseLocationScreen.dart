import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../Helper/url_helper.dart' as url_helper;
import 'package:car_washer/Helper/request_helper.dart';

class chooseLocationScreen extends StatefulWidget{
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
      "provider_id": 249,
      "latitude": x.latitude,
      "longitude": x.longitude
    };
    requestHelp.requestPost(uri, body).then((response){
      if(response.statusCode == 200){
        print("Done");
      }else{
        print("mohammed");
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
            onTap: (click){
              print("CLICKED");
              setState(() {
                markedLocation = click;
                print(markedLocation);
                _markers
                    .add(Marker(markerId: MarkerId('id-1'), position: markedLocation));
              });
            },
          ),

        ),
        TextButton(
          child: Text("Done"),
          onPressed: (){
            setProviderLocation(markedLocation);
          },
        )
      ],
    );
  }
}