import 'package:car_washer/screens/editProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import './editScreen.dart';

class ProfileScreen extends StatelessWidget{
  String name;
  String image;
  String email;
  String number;
  ProfileScreen({required this.name, required this.image,required this.email,required this.number, });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(image),
                      radius: 9.0.h,
                      backgroundColor: Colors.transparent,
                    ),
                    Text(name,style: TextStyle(
                      fontSize: 18,

                    ),),
                    SizedBox(height: 1.2.h,),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute( builder: (context) => EditProfileScreen(name: name, image: image,email: email, number: number)));
                        },
                        child: RichText(

                          text: TextSpan(
                            children: [
                              TextSpan(text: 'Edit',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              )),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.edit, size: 18, color: Colors.orange,),
                                ),
                              ),


                            ],

                          ),
                        ),
                    )
                  ],
                )
              ],
            ),
            Row(

              children: [
                Expanded(

                    child: Divider(color: Colors.black,
                      thickness: 2,
                      height: 5.0.h,)



                ),



              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(

                  text: TextSpan(
                    children: [

                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.attach_money, size: 18, color: Colors.black,),
                        ),
                      ),
                      TextSpan(text: 'Earning',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      )),

                    ],

                  ),
                ),
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, 'earning');
                }, icon: Icon(Icons.arrow_forward_ios, size: 18,))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(

                  text: TextSpan(
                    children: [

                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.star, size: 18, color: Colors.black,),
                        ),
                      ),
                      TextSpan(text: 'Review',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      )),

                    ],

                  ),
                ),
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, 'review');
                }, icon: Icon(Icons.arrow_forward_ios, size: 18,))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(

                  text: TextSpan(
                    children: [

                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.lock, size: 18, color: Colors.black,),
                        ),
                      ),
                      TextSpan(text: 'Password',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      )),

                    ],

                  ),
                ),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(name: "Password",Editingvalue: "",)));
                }, icon: Icon(Icons.arrow_forward_ios, size: 18,))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(

                  text: TextSpan(
                    children: [

                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.notifications, size: 18, color: Colors.black,),
                        ),
                      ),
                      TextSpan(text: 'Notification',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      )),

                    ],

                  ),
                ),
                Switch(value: false, onChanged: (bool? value){

                })
              ],
            ),
            Row(
              children: [
                Expanded(child: ElevatedButton(
                  child: Text("Log out",),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))
                 ),
                  onPressed: (){},

                ),

                )
              ],
            )
          ],
        ),
      ),
    );
  }

}