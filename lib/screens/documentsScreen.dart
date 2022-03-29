// Updates :
// take thumbnail word and png, reset date when click at upload


import 'dart:io';
import 'dart:typed_data';

import 'package:car_washer/myDrawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:thumbnailer/thumbnailer.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DocumentScreen extends StatefulWidget{
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double _height = 0;
  String _docName = "";
  late File file;
  late Uint8List bytes;
  int _current = 0;
  String _dateTime = "";
  // Widget getTableWidgets(List<dynamic> strings)
  // {
  //   List<TableRow> list = <TableRow>[];
  //   list.add(
  //     TableRow(
  //         children: [
  //           TableCell(child: Padding(
  //             padding: EdgeInsets.all(12),
  //             child: Text("Name"),
  //           )
  //           ),
  //           TableCell(child: Padding(
  //             padding: EdgeInsets.all(12),
  //             child: Text("Status"),
  //           )),
  //           TableCell(child: Padding(
  //             padding: EdgeInsets.all(12),
  //             child: Text("Expiry Date"),
  //           )),
  //           TableCell(child: Padding(
  //             padding: EdgeInsets.all(12),
  //             child: Text("Action"),
  //           )),
  //         ]
  //     ),
  //   );
  //   for(var i = 0; i < strings.length; i++){
  //     list.add(new
  //     TableRow(
  //         children: [
  //           //Padding(
  //           //                                   padding: EdgeInsets.all(12),
  //           //                                   child: Text("Name"),
  //           //                                 )
  //           TableCell(child: Padding(
  //             padding: EdgeInsets.all(12),
  //             child: Text(strings[i]["name"]),
  //           )
  //           ),
  //           TableCell(child: Padding(
  //             padding: EdgeInsets.all(12),
  //             child: Text(strings[i]["status"]),
  //           )),
  //           TableCell(child: Padding(
  //             padding: EdgeInsets.all(12),
  //             child: Text(strings[i]["expiry-date"]),
  //           )),
  //           TableCell(
  //               child: strings[i]["status"] == "Valid" || strings[i]["status"] == "Expired"?
  //
  //               TextButton(onPressed: (){}, child: Text("update")):
  //               TextButton(onPressed: (){}, child: Text("upload"))
  //           ),
  //         ]
  //     )
  //     );
  //   }
  //   return new Table(
  //     border: TableBorder.all(),
  //     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  //     children: list,) ;
  // }
  //
  //
  // List _documents = [];


  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString(
  //       'assets/documents.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _documents = data["documents"];
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    // readJson();
    List documents = [{
        "id": 19,
        "name": "ID",
        "status": "MISSING",
        "expiry-date": "13-12-1999"

      }, {
        "id": 2,
        "name": "Washer Lisence",
        "status": "Valid",
        "expiry-date": "13-12-1999"

      }, {
        "id": 3,
        "name": "Owner ID",
        "status": "Expired",
        "expiry-date": "13-12-1999"

      }];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Documents"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
          onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          },
        ),

      ),
      drawer: myDrawer(index: 4,),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.05,

            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap:_height == 0?null:(){
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

                                  color: documents[index]["status"] == "Valid"?Colors.greenAccent: Colors.redAccent),)
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text("Expiry_Date: ${documents[index]["expiry-date"]}"),
                            ),
                            ElevatedButton(onPressed:_height > 0?(){}: ()async{
                              final result = await FilePicker.platform.pickFiles();
                              if (result == null) return;
                              file = File(result.files.first.path!);
                              bytes = await file.readAsBytesSync();
                              setState(() {
                                _current = index;
                                _docName = "${result.files.first.name}";
                                // _docPath = "${file.path}";
                                // print(file.bytes);
                                _height = MediaQuery.of(context).size.height / 3;
                              });
                            },
                                child:  Text( documents[index]["status"] == "Valid"? "Update": "Upload"),
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
            }),


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
                              setState(() {
                                _height = 0;
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
                                mimeType: 'application/pdf',
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