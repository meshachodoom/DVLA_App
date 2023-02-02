import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile_demo/Admin/Vehicle/vehicleLicenseList.dart';

class ViewVehicleLicense extends StatefulWidget {
  final String docid;

  const ViewVehicleLicense({ key, this.docid }) : super(key: key);

  @override
  _ViewVehicleLicenseState createState() => _ViewVehicleLicenseState(docid);
}

class _ViewVehicleLicenseState extends State<ViewVehicleLicense> {
  String docids;
  _ViewVehicleLicenseState(this.docids);

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
           title: Text("User Profile",
           style: TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: "Signatra"),
           ),
           centerTitle: true,
        ),
         body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
          child: Form(
            //key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'User Details',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
            
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text('Vehicle Owner',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_vehicleOwnerController.text,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            ),
            SizedBox(height: 20),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text('Car Number',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_carNumberController.text,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            ),
            SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Expiry Date',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_expiryDateController.text,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
            SizedBox(height: 20), 
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text('Use',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_useController.text,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            ),
            SizedBox(height: 20),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text('Colour',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_colourController.text,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            ),
            SizedBox(height: 20),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text('Make',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_makeController.text,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            ),
            SizedBox(height: 20),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text('Model',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_modelController.text,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            ),
            
                    ],
                ),
            ),
              ],
        ),
         ),
         
        ),
                  
    );
      
  }
}