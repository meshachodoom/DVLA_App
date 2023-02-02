import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile_demo/Admin/Vehicle/vehicleLicenseList.dart';

class EditVehicleLicense extends StatefulWidget {
   final String docid;

  const EditVehicleLicense({ key, this.docid }) : super(key: key);
  @override
  _EditVehicleLicenseState createState() => _EditVehicleLicenseState(docid);
}

class _EditVehicleLicenseState extends State<EditVehicleLicense> {
  String docids;
  _EditVehicleLicenseState(this.docids);

   final _key = GlobalKey<FormState>();

  TextEditingController _vehicleOwnerController = TextEditingController();
  TextEditingController _carNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _useController = TextEditingController();
  TextEditingController _colourController = TextEditingController();
  TextEditingController _makeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  String uid;

  @override
  void initState(){
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try{
      await Firestore.instance.collection('VehicleLicenseDetails').document('$docids').get().then((ds){
        if(ds.exists){
          setState((){
            _vehicleOwnerController.text = ds.data['vehicleOwner'];
            _carNumberController.text = ds.data['carNumber'];
            _expiryDateController.text = ds.data['expiryDate'];
            _useController.text = ds.data['use'];
            _colourController.text = ds.data['colour'];
            _makeController.text = ds.data['make'];
            _modelController.text = ds.data['model'];
          });
        }
      });

      print('Data User: $docids');
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateData() async {
        await Firestore.instance.collection('VehicleLicenseDetails').document('$docids').updateData({
        "vehicleOwner": _vehicleOwnerController.text, "carNumber": _carNumberController.text, "expiryDate": _expiryDateController.text, "use": _useController.text,
        "colour": _colourController.text, "make": _makeController.text, "model": _modelController.text}).
          catchError((e) {
           print(e);
         }
         
         );
  }
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
          controller: _expiryDateController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Expiry date cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Expiry Date',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
  TextFormField(
          controller: _useController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Use cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Use',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
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
           child: Text("Update details"),
           style: ElevatedButton.styleFrom(
           primary: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
           onPressed: () {
           if (_key.currentState.validate()) {
           updateData();
           showDialog(context: context,builder: (BuildContext context) {
           return AlertDialog(
           content: new Text("User Details updated successfully"),
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
          ),
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
}