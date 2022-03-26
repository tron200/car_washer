import 'package:car_washer/myDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';


class AddAccountScreen extends StatefulWidget{
  @override
  _AddAccountScreenState createState() => _AddAccountScreenState();
}


class _AddAccountScreenState extends State<AddAccountScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> list = ["AED","USD","EGP"];

  TextEditingController _BankNameController = new TextEditingController();
  TextEditingController _AccountNumberController = new TextEditingController();
  TextEditingController _AccountHolderController = new TextEditingController();
  String _countryName = "";
  String _Currency = "";

  void addAccount (){

  }
  void cancel(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text("Add Account"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
          onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: myDrawer(index: 5,),
      body: Column(
        children: [
          TextField(
            controller: _BankNameController,
            decoration: InputDecoration(
              hintText: "Bank Name"
            ),
          ),
          TextField(
            controller: _AccountNumberController,
            decoration: InputDecoration(
                hintText: "Account Number"
            ),
          ),
          TextField(
            controller: _AccountHolderController,
            decoration: InputDecoration(
                hintText: "Account Holder Name"
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showCountryPicker(
                context: context,
                //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                exclude: <String>['KN', 'MF'],
                //Optional. Shows phone code before the country name.
                showPhoneCode: true,
                showWorldWide: false,
                onSelect: (Country country) {
                  print('Select country: ${country.name}');
                  setState(() {
                    _countryName = country.name;
                  });
                },
                // Optional. Sets the theme for the country list picker.
                countryListTheme: CountryListThemeData(
                  // Optional. Sets the border radius for the bottomsheet.
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  // Optional. Styles the search field.
                  inputDecoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Start typing to search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                      ),
                    ),
                  ),


                ),
              );
            },
            child: const Text('Select Country'),
          ),
          ElevatedButton(onPressed: (){
            showMaterialScrollPicker<String>(
              context: context,
              title: 'Pick Your State',
              items: list,
              selectedItem: list[0],
              onChanged: (value){
                print(value);
                setState(() {
                  _Currency = value;

                });
              }
            );
          }, child: Text("Select Currency")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: addAccount, child: Text("Add Account")),
              ElevatedButton(onPressed: cancel, child: Text("Cancel"))
            ],
          )
        ],
      )
    );
  }
}