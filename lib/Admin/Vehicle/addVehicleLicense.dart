import 'package:flutter/material.dart';
import 'package:userprofile_demo/Admin/Vehicle/vehicleLicenseList.dart';
import 'package:intl/intl.dart';
import 'package:userprofile_demo/DatabaseManager/DatabaseManager.dart';

class VehicleLicenseAdd extends StatefulWidget {
  const VehicleLicenseAdd({ key }) : super(key: key);

  @override
  _VehicleLicenseAddState createState() => _VehicleLicenseAddState();
}

class _VehicleLicenseAddState extends State<VehicleLicenseAdd> {

  final _key = GlobalKey<FormState>();

  TextEditingController _vehicleOwnerController = TextEditingController();
  TextEditingController _carNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  String _useController;
  TextEditingController _colourController = TextEditingController();
  TextEditingController _makeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: Colors.deepPurple,
           leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
             Route route = MaterialPageRoute(builder: (c) => VehicleLicenseList());
                   Navigator.pushReplacement(context, route);
          },
        ),
           title: Text("Add new user",
           style: TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: "Signatra"),
           ),
           centerTitle: true,
        ),
         body: SingleChildScrollView(
            scrollDirection: Axis.vertical,

      
       child: Center(
            child: Form(
            key: _key,
            child: Column(
                children: [
                Text(
                  'Vehicle Details',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
          TextFormField(
          controller: _vehicleOwnerController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Vehicle owner cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Vehicle Owner',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
          controller: _carNumberController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Car Number cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Car Number',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
            validator: (value){
            if (value.isEmpty) {
          return 'Date of Birth cannot be empty';
          } else
          return null;
          },
          controller: _expiryDateController,
          decoration: InputDecoration( 
          prefixIcon: Icon(Icons.calendar_today), 
          labelText: "Expiry Date" 
           ),
          readOnly: true, 
          onTap: () async {
          DateTime pickedDate = await showDatePicker(
          context: context, initialDate: DateTime.now(),
          firstDate: DateTime(1960), 
          lastDate: DateTime(2022)
          );          
          if(pickedDate != null ){
           print(pickedDate);  
           String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
            print(formattedDate); 
                      setState(() {
                         _expiryDateController.text = formattedDate;  
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
            ),
  DropdownButtonFormField<String>(
    validator: (value) => value == null
                    ? 'Please select use' : null,
  focusColor:Colors.deepPurple,
  value: _useController,
  elevation: 5,
  style: TextStyle(color: Colors.deepPurple),
  iconEnabledColor:Colors.black,
  items: <String>[
    'Private','Public'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.deepPurple),),
    );
  }).toList(),
  hint:Text(
    "Please select Use",
    style: TextStyle(
        color: Colors.deepPurple,
        fontSize: 16,
        fontWeight: FontWeight.w400),
  ),
  onChanged: (String value) {
    setState(() {
      _useController = value;
    });
  },
),
          TextFormField(
          controller: _colourController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Colour cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Colour',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
          controller: _makeController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Make cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Make',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
          controller: _modelController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Model cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Model',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
        SizedBox(height: 20),
           Container(
             height: 40,
             width: 150,
           child: ElevatedButton(
           child: Text("Save details"),
           style: ElevatedButton.styleFrom(
           primary: Colors.deepPurple,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
           onPressed: () {
           if (_key.currentState.validate()) {
           renewVehicleLicense();
           showDialog(context: context,builder: (BuildContext context) {
           return AlertDialog(
           content: new Text("User added successfully"),
           actions: <Widget>[
           ElevatedButton(
           child: Text("Ok"),
           style: ElevatedButton.styleFrom(
           primary: Colors.deepPurple,),
           onPressed: () {
           Route route = MaterialPageRoute(builder: (c) => VehicleLicenseList());
                   Navigator.pushReplacement(context, route); 
          },
      ),
       ],
         );
          },
           );
          
                 }
                },
            
       ),
           )
     ],
      ),
       ),
              ],
            ),
            ),
            ),

    ),
    );
  }

  void renewVehicleLicense() async {
        await DatabaseManager().renewVehicleLicenseData(_vehicleOwnerController.text,_carNumberController.text, _expiryDateController.text,_useController, 
         _colourController.text, _makeController.text, _modelController.text, uid);
  }
}