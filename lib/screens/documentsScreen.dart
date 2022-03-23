import 'dart:convert';

import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DocumentScreen extends StatefulWidget{
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget getTableWidgets(List<dynamic> strings)
  {
    List<TableRow> list = <TableRow>[];
    list.add(
      TableRow(
          children: [
            TableCell(child: Padding(
              padding: EdgeInsets.all(12),
              child: Text("Name"),
            )
            ),
            TableCell(child: Padding(
              padding: EdgeInsets.all(12),
              child: Text("Status"),
            )),
            TableCell(child: Padding(
              padding: EdgeInsets.all(12),
              child: Text("Expiry Date"),
            )),
            TableCell(child: Padding(
              padding: EdgeInsets.all(12),
              child: Text("Action"),
            )),
          ]
      ),
    );
    for(var i = 0; i < strings.length; i++){
      list.add(new
      TableRow(
          children: [
            //Padding(
            //                                   padding: EdgeInsets.all(12),
            //                                   child: Text("Name"),
            //                                 )
            TableCell(child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(strings[i]["name"]),
            )
            ),
            TableCell(child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(strings[i]["status"]),
            )),
            TableCell(child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(strings[i]["expiry-date"]),
            )),
            TableCell(
                child: strings[i]["status"] == "Valid" || strings[i]["status"] == "Expired"?

                TextButton(onPressed: (){}, child: Text("update")):
                TextButton(onPressed: (){}, child: Text("upload"))
            ),
          ]
      )
      );
    }
    return new Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: list,) ;
  }


  List _documents = [];


  Future<void> readJson() async {
    final String response = await rootBundle.loadString(
        'assets/documents.json');
    final data = await json.decode(response);
    setState(() {
      _documents = data["documents"];
    });
  }
  @override
  Widget build(BuildContext context) {
    readJson();
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
      drawer: myDrawer(index: 3,),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: getTableWidgets(_documents),
            
         
      ),
    );
  }

}