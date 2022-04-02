
import 'dart:convert';

import 'package:car_washer/chooseLocationScreen.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service.dart';
import 'package:car_washer/Helper/url_helper.dart' as url_helper;

import '../Helper/request_helper.dart';

class EditServicesScreen extends StatefulWidget{
  String id;
  Map<String, dynamic> Allservices;
  EditServicesScreen({required this.id, required this.Allservices });
  @override
  _EditServicesScreenState createState() => _EditServicesScreenState();
}

class _EditServicesScreenState extends State<EditServicesScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<bool> values = [];
  List<dynamic> _services = [];
  String id = "";
  List<Service> servicesControllers = [];
  late List<String> choosedServices;
  late List<String> choosedServicesPrices;
  request_helper requestHelp = new request_helper();

  url_helper.Constants url_help = new url_helper.Constants();
  Future<void> getAllServices() async {
    Uri url = Uri.parse(url_help.getAllServices);
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};

    await requestHelp.requestGet(url,header).then((responce) async {
      if (responce.statusCode == 200) {
        _services =  json.decode(responce.body);
        print(_services);
        values = List<bool>.filled(_services.length, false);
        _services.forEach((element) {
          servicesControllers.add(new Service(TextEditingController(), element["id"]));
        });
      }

    });

  }



  List<dynamic> servicesId = [];
  List<dynamic> servicesPrices = [];
  Future<void> setProviderServices() async{
    servicesId = [];
    servicesPrices = [];
    Uri uri = Uri.parse(url_help.setServices);
    (servicesControllers.where((element) => element.getController().text.isNotEmpty).toList()).forEach((element) {
      servicesId.add(element.getServiceId());
      servicesPrices.add(element.getController().text);
    });
    print(servicesId);
    print(servicesPrices);
    Map<String, dynamic> body = {
      "provider_id" : id,
      "services_id" :servicesId,
      "service_price" : servicesPrices

    };
    requestHelp.requestPost(uri, body).then((response){
      if(response.statusCode == 200){
        print(response.body);
      }
    });
  }
  void showLoading() async{
    await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black);
  }
  void hideLoading() async{
    await EasyLoading.dismiss();

  }
  void showError(String msg){
    EasyLoading.showError(msg);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showLoading();
    getAllServices().then((value){

      for(int i= 0 ; i<servicesControllers.length;i++){
          for(int j = 0; j < widget.Allservices["service"].length;j++){
            if(servicesControllers[i].getServiceId() == widget.Allservices["service"][j]["service_type_id"]){
              setState(() {
                hideLoading();
              servicesControllers[i].getController().text = widget.Allservices["service"][j]["service_price"];
              values[i] = true;
              });
              print(servicesControllers);
              break;
            }
          }
        }

    });
    id = widget.id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Edit Services"),
        actions: [
          TextButton(
            child: Text("Done"),
            onPressed: (){

            },
          ),
        ],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },

        ),
      ),
      body:  ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: _services.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                index == 0?
                Row(
                  children: [
                    Expanded(child: Text("Available"),flex: 1,),
                    Expanded(child: Container(child: Text("ٍService Name")
                      , margin: EdgeInsets.only(left: 8, top: 5),
                    ),flex: 2,),
                    Expanded(child: Text("Service Price (AED)"),flex: 3,)
                  ],
                ): Container(),
                Row(
                  children: [
                    Expanded(child: Checkbox(value: values[index], onChanged: (value){
                      setState(() {
                        values[index] = value!;
                      });
                    }),flex: 1,),
                    Expanded(child: Container(child: Text(_services[index]["name"]), margin: EdgeInsets.only(left: 8),),flex: 2,),
                    Expanded(child: TextField(
                      decoration: InputDecoration(
                        hintText: "Price (AED)",
                      ),
                      enabled: values[index],

                      controller: servicesControllers[index].getController(),

                    ),flex: 3,)
                  ],
                ),
              ],
            ),
          );
        },
      ),


    );
  }
}