import 'package:car_washer/myDrawer.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sizer/sizer.dart';


class otpVerfication extends StatefulWidget{
  @override
  _otpVerficationState createState() => _otpVerficationState();
}

class _otpVerficationState extends State<otpVerfication>{
  int _index = 0;
  String dialCodesDigits = "+00";
  final TextEditingController _phoneController = TextEditingController();
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
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Phone Number'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: CountryCodePicker(
                  onChanged: (country){
                    setState(() {
                      dialCodesDigits = country.dialCode!;
                    });
                  },
                  initialSelection: "IT",
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  favorite: ["+981","+1","US"],
                ),
              ),
              Container(
                width: 50.0.w,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Phone Number",

                  ),
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                ),
              )
            ],
          )
        ),
        Step(
          title: Text('Otp Verification'),
          content: Padding(
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

                }catch(e){

                }
              },
            ),
          ),
        ),
      ],
    )
    ,
    );
  }
}