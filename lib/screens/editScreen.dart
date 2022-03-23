import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget{
  String name;
  String Editingvalue;
  EditScreen ({Key? key , required this.name, required this.Editingvalue}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Edit ${name}"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Text(Editingvalue),
    );
  }
}