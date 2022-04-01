// Updates :
// take thumbnail word and png, reset date when click at upload


import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:car_washer/bageIcon.dart';
import 'package:car_washer/myDrawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:open_file/open_file.dart';
import 'package:thumbnailer/thumbnailer.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:car_washer/Helper/request_helper.dart';
import '../Helper/url_helper.dart' as url_helper;
import 'package:path_provider/path_provider.dart';

class DocumentScreen extends StatefulWidget{
  String id;
  DocumentScreen({required this.id});
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double _height = 0;
  String _docName = "";
  String _docEX = "";
  late File file;
  late Uint8List bytes;
  int _current = 0;
  String _dateTime = "";
  List<dynamic> documents = [];
  List <dynamic> AllDocuments = [];
  request_helper requestHelp = new request_helper();

  url_helper.Constants url_help = new url_helper.Constants();
  Future<void> getProviderDocuments() async {
    Uri url = Uri.parse("${url_help.getAllDocuments}");
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};

    await requestHelp.requestGet(url,header).then((responce){
      if (responce.statusCode == 200) {
        // print(json.decode(responce.body));
        // json.decode(responce.body)["requests"];

          AllDocuments = json.decode(responce.body);


        }

    });

  }
bool there = false;

  Future<void> uploadDocuments(File file, String expire, String docId) async{
    Uri uri = Uri.parse(url_help.uploadDocument);
    // Map<String, dynamic> body ={
    //   "document_id": docId,
    //   "provider_id": double.parse(widget.id),
    //
    // };
    var request = http.MultipartRequest('POST', uri);
    request.fields["document_id"] = docId;
    request.fields["provider_id"] = widget.id;
    request.fields["expires_at"] = expire;
    request.files.add(
        await http.MultipartFile.fromPath(
            'document',
            file.path
        )
    );
     await request.send().then((response){
       if(response.statusCode == 200){
         print("Done");
       }else{
         print("Fail");
       }
     });


    // requestHelp.requestPost(uri, body,header).then((response){
    //   if(response.statusCode == 200){
    //     print(response.body);
    //   }else{
    //     print("Fail");
    //   }
    // });
  }


  Future<void> getDocuments() async {
    Uri url = Uri.parse("${url_help.getProviderDocuments}${widget.id}");
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};

    await requestHelp.requestGet(url,header).then((responce) async {
      if (responce.statusCode == 200) {
        // print(json.decode(responce.body));
        // json.decode(responce.body)["requests"];

        documents = json.decode(responce.body);
        int length = documents.length;
        setState(() {
          print(AllDocuments);
          for(int i = 0; i < AllDocuments.length; i++){
            there = false;

            for(int j = 0; j < length;j++){
              // print(AllDocuments[i]["id"] == documents[j]["document_id"]);
              if(AllDocuments[i]["id"] == double.parse(documents[j]["document_id"])){
                there = true;
                print("$j ::::::::::::::::::::: $there");
                break;
              }

            }
            if(there == false){
              documents.add(
                  {
                    "id": AllDocuments[i]["id"],
                    "name":AllDocuments[i]["name"],
                    "status": "MISSING",

                  }
              );
            }

          }
          // print(documents);
        });
      }

    });

  }

  void showError(String msg){
    EasyLoading.showError(msg);
  }
  Widget getAllDocuments(List<dynamic> documents){
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap:_height == 0 && documents[index]["status"] != "MISSING" ?(){
              Uri uri = Uri.parse("${url_help.getPhoto}${documents[index]["url"]}");
              Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};
              requestHelp.requestGet(uri, header).then((value) async{
                Uint8List uint8list = value.bodyBytes;
                var buffer = uint8list.buffer;
                ByteData byteData = ByteData.view(buffer);
                Directory tempDir = await getTemporaryDirectory();
                await File('${tempDir.path}/img').writeAsBytes(
                    buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)).then((value) {
                  OpenFile.open(value.path);
                });



              });

            }:(){
              setState(() {
                _height = 0;
              });
            },
            child: Card(

              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              elevation: 10,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)),
              ),
              color: Colors.white,
              child:Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text("Document Name: ${documents[index]["name"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Text("Status: "),
                          Text("${documents[index]["status"]}", style: TextStyle(

                              color: documents[index]["status"] == "Active"?Colors.greenAccent: documents[index]["status"] == "ASSESSING"?Colors.orange:Colors.redAccent),)
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child:documents[index]["status"] == "MISSING" ?Container(): Row(
                            children: [
                              Text("Expiry_Date: "),
                              Text("${documents[index]["expires_at"]}".split(" ")[0])
                            ],
                          ),
                        ),
                        ElevatedButton(onPressed:_height > 0?(){}: ()async{
                          final result = await FilePicker.platform.pickFiles();
                          if (result == null) return;
                          file = File(result.files.first.path!);
                          bytes = await file.readAsBytesSync();
                          setState(() {
                            _current = index;
                            _docName = "${result.files.first.name}";
                            _docEX = "${result.files.first.extension}";

                            // _docPath = "${file.path}";
                            print(_docEX);
                            if(_docEX == "txt"){
                              showError("Wrong Type Of Data");
                            }else{
                              _height = MediaQuery.of(context).size.height / 3;

                            }
                          });
                        },
                            child:  Text( documents[index]["status"] == "Valid" || documents[index]["status"] == "ASSESSING"? "Update": "Upload"),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),

                                    )
                                )
                            )

                        )


                      ],
                    ),
                    documents[index]["status"] == "MISSING"?
                    Container():
                    Align(
                      alignment: Alignment.center,
                      child: Text("Click To View", style: TextStyle(
                          fontSize: 8,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                      ),)
                      ,
                    )
                  ],
                ),
              ),

            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProviderDocuments().then((value){
      getDocuments();
    });


  }
  @override
  Widget build(BuildContext context) {
    // readJson();
    // List documents = [{
    //     "id": 19,
    //     "name": "ID",
    //     "status": "MISSING",
    //     "expiry-date": "13-12-1999"
    //
    //   }, {
    //     "id": 2,
    //     "name": "Washer Lisence",
    //     "status": "Valid",
    //     "expiry-date": "13-12-1999"
    //
    //   }, {
    //     "id": 3,
    //     "name": "Owner ID",
    //     "status": "Expired",
    //     "expiry-date": "13-12-1999"
    //
    //   }];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Documents"),
        centerTitle: true,
        leading: BadgeIcon(scaffoldKey: _scaffoldKey)

      ),
      drawer: myDrawer(index: 5,),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.05,

            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: getAllDocuments(documents),


          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              height: _height,
              width: double.infinity,

              duration: new Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
              child: Card(
                elevation: 20,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
                ),
                child: Container(
                  padding: EdgeInsets.all(12),

                    child: _height ==0? Container():
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Document Name: ${documents[_current]["name"]}", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),),
                            TextButton(onPressed: (){
                              // print(file.readAsStringSync());

                              uploadDocuments(file, _dateTime.split(" ")[0], "${documents[_current]["id"]}").then((value){
                                getDocuments();
                                setState(() {
                                  _height = 0;
                                });
                              });

                            }, child: Text("Done"))
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            OpenFile.open(file.path);
                          },
                          child: Stack(
                            children: [

                              Thumbnail(
                                dataResolver: () async {
                                  return bytes;

                                },

                                mimeType: _docEX == "pdf"?'application/pdf':_docEX == "png"?'image/png':'image/jpg',
                                widgetSize: 150,
                                decoration: WidgetDecoration(
                                    wrapperBgColor: Colors.white),
                              ),
                               Positioned(
                                 bottom: 0.0,
                                 width: 150,
                                 child: Container(
                                   color: Colors.black54,
                                     child: Row(
                                       children: <Widget>[
                                         Flexible(
                                             child: new Text(_docName,style: TextStyle(
                                                 color: Colors.white,
                                                 fontStyle: FontStyle.italic
                                             ),))
                                       ],
                                     )),
                                 // child: Container(
                                 //    color: Colors.black54,
                                 //    height: 30,
                                 //    child: Text(_docName,style: TextStyle(
                                 //      color: Colors.white,
                                 //      fontStyle: FontStyle.italic
                                 //    ),),
                                 //   alignment: Alignment.center,
                                 //  ),

                               ),

                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: (){
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2050, 6, 7), onChanged: (date) {
                                    print('change $date');

                                  }, onConfirm: (date) {
                                    print('confirm $date');

                                    setState(() {
                                      _dateTime = date.toString();
                                    });
                                  }, currentTime: DateTime.now(), locale: LocaleType.ar);

                            }, child: Text("Click To Pick an Expiry Date ")),
                            Text(_dateTime.split(" ")[0], style: TextStyle(
                              color: Colors.black,
                              fontSize: 15
                            ),)
                          ],
                        )
                      ],
                    )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}