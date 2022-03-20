import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'login.dart';

class register extends StatefulWidget{
  static String id = 'register_screen';

  @override
  _registerstate createState() => _registerstate();

}



class _registerstate extends State<register> {
  List _services = [];
  List<bool> values = [false, false];


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
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => login())
        ,);
    }
    void register(){
      //here _emailController.text

    }
    TextEditingController _emailController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _passwordconfirmController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();

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
                          controller: _phoneController,
                          decoration: InputDecoration(
                              labelText: "Phone",
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
                      Container(
                        height: 20.0.h,
                        child: ListView.builder(
                          itemCount: _services.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                                child: Card(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Checkbox(value: values[index], onChanged: (bool? value){
                                            values[index] = value!;
                                          }),
                                          Container(
                                            width: 25.0.w,
                                            child: Text(_services[index]["name"]),
                                          ),
                                          Expanded(
                                              child: TextField(

                                                decoration: InputDecoration(
                                                  hintText: "Service Price (AED)",

                                                ),
                                              )
                                          )

                                        ],
                                      ),
                                    )
                                )
                            );
                          },
                        ),
                      ),
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
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Register',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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