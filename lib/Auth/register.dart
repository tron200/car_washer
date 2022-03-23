import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class register extends StatefulWidget{
  static String id = 'register_screen';

  @override
  _registerstate createState() => _registerstate();

}



class _registerstate extends State<register> {

  Widget getTableWidgets(List<dynamic> strings)
  {
    List<TableRow> list = <TableRow>[];
    list.add(TableRow(
        children: [
          TableCell(child: Padding(
            padding: EdgeInsets.all(12),
            child: Text("Available"),
          )),
          TableCell(child: Padding(
            padding: EdgeInsets.all(12),
            child: Text("Service Name"),
          )),
          TableCell(child: Padding(padding: EdgeInsets.all(12),child: Text("Service Price (AED)"),))

        ]
    ));
    for(var i = 0; i < strings.length; i++){
      list.add(new TableRow(children: [
            TableCell(
              child: Checkbox(
                value: values[i],
                onChanged: (bool? value){
                setState(() {
                  values[i] = value!;
                });
            }),),
            TableCell(child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(strings[i]["name"]),
            )),
            TableCell(child:  TextField(

                  decoration: InputDecoration(
                    hintText: "Service Price (AED)",
                  ),
                )

            )
       ]
        ,)
      );
    }
    return new Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(85),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: list,) ;
  }


  List _services = [];
  List<bool> values = [false,false,false];


  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/services.json');
    final data = await json.decode(response);
    setState(() {
      _services = data["services"];
    });
  }
  @override
  Widget build(BuildContext context) {

    readJson();
    void click() {
      Navigator.pushNamed(context, 'login');

    }
    void register(){
      //here _emailController.text

    }
    TextEditingController _emailController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _passwordconfirmController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,


                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,


                    children: [

                      SizedBox(height: 15.0.h,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 7.5.h,
                        child:  TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              labelText: "User name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              )
                          ),
                        ),
                      ),

                      SizedBox(height: 1.2.h,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 7.5.h,
                        child:  TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: "Email Address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 1.2.h,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 7.5.h,
                        child:  TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              )
                          ),
                        ),
                      ),

                      SizedBox(height: 1.2.h,),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 7.5.h,
                        child:  TextField(
                          controller: _passwordconfirmController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Password Confirmation",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 2.0.h,),

                      getTableWidgets(_services),

                      SizedBox(height: 1.2.h),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Color(0xff3fbcef)
                          ),
                          child:  Padding(
                            padding: EdgeInsets.all(12.0),
                            child: TextButton(
                              child: Text('Register',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                              onPressed: register,

                            ),
                          ),
                        ),
                      ),


                      Row(
                        children: [
                          Text("You Already have an account?",style: TextStyle(color: Colors.black),),
                          TextButton(
                            onPressed: click,
                            child: const Text("Login",
                              style: TextStyle(
                                  color: Color(0xff3fbcef)
                              ),
                            ),
                          )
                        ],
                      )


                    ],
                  ),
                )
            ),
          ],
        ),
      ),
      )
    );

  }
}