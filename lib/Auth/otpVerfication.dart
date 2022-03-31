import 'dart:collection';

import 'package:car_washer/myDrawer.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sizer/sizer.dart';


class otpVerfication extends StatefulWidget{
  Map<String, dynamic> body;
  otpVerfication({required this.body});
  @override
  _otpVerficationState createState() => _otpVerficationState();
}

class _otpVerficationState extends State<otpVerfication>{
  int _index = 0;
  static Map<String, dynamic> body = new HashMap();


  // final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFoucsNode = FocusNode();
  String? VerficationCode;
  final BoxDecoration pinOtpCodeVerfication = BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.grey
    )
  );

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    body = widget.body;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String dialCodesDigits = body['dialCodesDigits'];
    String phone = body['mobile'];
    print("hi $dialCodesDigits  $phone");
    return Scaffold(
      appBar: AppBar(
        title: Text("Otp Verfication"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body:
        Container(

            padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
            child: PinPut(
              fieldsCount: 6,
              textStyle: TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              controller: _otpController,
              focusNode: _otpFoucsNode,
              selectedFieldDecoration: pinOtpCodeVerfication,
              submittedFieldDecoration: pinOtpCodeVerfication,
              followingFieldDecoration: pinOtpCodeVerfication,
              pinAnimationType: PinAnimationType.rotation,
              onSubmit: (pin) async{
                try{
                  String dialCodesDigits = body['dialCodesDigits'];
                  String phone = body['mobile'];
                  print("hi $dialCodesDigits  $phone");
                }catch(e){

                }
              },
            ),
          )
        );


  }
}