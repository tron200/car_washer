import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class login extends StatefulWidget{
  static String id = 'login_screen';

  @override
  _loginstate createState() => _loginstate();

}



class _loginstate extends State<login> {

  @override
  Widget build(BuildContext context) {
    void click() {

    }
    void signin(){
      //here _emailController.text

    }
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
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

                        SizedBox(height: 35.0.h,),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 7.5.h,
                          child: TextField(
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
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                )
                            ),
                          ),
                        ),

                        SizedBox(height: 2.0.h,),

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
                            child: TextButton(
                              onPressed: signin,
                              child: Text('Login', style: TextStyle(
                                color: Colors.white,
                                fontSize: 20

                              ),),

                            )
                          ),
                        ),
                        SizedBox(height: 1.0.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: click,
                              child: const Text("Forget Password",
                                style: TextStyle(
                                    color: Color(0xff3fbcef)
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(

                          children: [
                            Expanded(child: Column(
                              children: [

                                Divider(color: Colors.black,
                                  thickness: 1,
                                  height: 0.5.h,)


                              ],
                            )),

                            Text("  or  "),
                            Expanded(child: Column(
                              children: [

                                Divider(color: Colors.black,
                                  thickness: 1,
                                  height: 0.5.h,)


                              ],
                            )),
                          ],

                        ),
                        SizedBox(height: 2.5.h,),
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
                              child: Text('Login with Facebook',
                                style: TextStyle(color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text("You don't have an account?",style: TextStyle(color: Colors.black),),
                            TextButton(
                              onPressed: click,
                              child: const Text("Register",
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