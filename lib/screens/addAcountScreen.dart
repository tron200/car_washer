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

  Widget InputTaker(TextEditingController controller, String hintTitle){
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Color(0xffEAEEF6), borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: TextStyle(fontSize: 18, color: Color(0xffB1B2BB), fontStyle: FontStyle.italic),
            contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            border: InputBorder.none,


          ),
          keyboardType: TextInputType.name,
        ),
      ),
    );
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
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            InputTaker(_BankNameController, "Bank Name"),
            InputTaker(_AccountNumberController, "Account Number"),
            InputTaker(_AccountHolderController, "Account Holder Name"),
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
        ),
      )
    );
  }
}