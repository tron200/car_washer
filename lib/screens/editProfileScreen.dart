import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'editScreen.dart';

class EditProfileScreen extends StatelessWidget{
  String name;
  String image;
  String email;
  String number;
  EditProfileScreen({required this.name, required this.image,required this.email,required this.number, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Edit Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 9.0.h,
              backgroundColor: Colors.transparent,
            ),
            Text("Name",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),),
            SizedBox(height: 2.2.h,),
            TextButton(
             child: Text(name,style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(name: "Name",Editingvalue: "Jason Bor3y",)));

              },
            ),
            SizedBox(height: 10.0.h,),
            Text("Email",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),),
            SizedBox(height: 2.2.h,),
            TextButton(
                child: Text(email,style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(name: "Email",Editingvalue: "Jason@gmail.com",)));

              },
            ),
            SizedBox(height: 10.0.h,),
            Text("Mobile Number",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),),
            SizedBox(height: 2.2.h,),

            TextButton(child: Text(number,style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(name: "Number",Editingvalue: "1124472355",)));

              },
            ),



          ],
        ),
      ),
    );
  }
}