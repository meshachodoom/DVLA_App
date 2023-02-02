import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userprofile_demo/Homepage.dart';
import 'package:userprofile_demo/Widgets/DriverLicense/payRenew.dart';
import 'package:userprofile_demo/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:userprofile_demo/Services/AuthenticationService.dart';
import 'package:userprofile_demo/DatabaseManager/DatabaseManager.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class VehicleScreen extends StatefulWidget {
  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}
class _VehicleScreenState extends State<VehicleScreen> {
   DateTime selected;

final _key = GlobalKey<FormState>();
final AuthenticationService _auth = AuthenticationService();
 //final databaseReference = Firestore.instance;
  
  TextEditingController _dateOfPurchaseController = TextEditingController();
  TextEditingController _engineNumberController = TextEditingController();
  TextEditingController _vehicleColourController = TextEditingController();
  TextEditingController _vehicleMakeController = TextEditingController();
  TextEditingController _vehicleTypeController = TextEditingController();
  TextEditingController _yearOfManufactureController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _religionController = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String _idTypeController;

  String uid;
   String _imageUrl;

  File _imageFile;

   final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

Future uploadImageToFirebase() async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
    _imageUrl = await (await task.onComplete).ref.getDownloadURL();
  }

   
  @override

  Widget build(BuildContext context) {
 return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
           title: Text("DVLA",
           style: TextStyle(fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
           ),
           centerTitle: true,
           actions: [
           RaisedButton(
              onPressed: () {
               Route route = MaterialPageRoute(builder: (c) => Homepage());
                   Navigator.pushReplacement(context, route);
              },
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
              color: Colors.deepPurple,
            ),
           RaisedButton(
              onPressed: () async {
                await _auth.signOut().then((result) {
                  Navigator.of(context).pop(true);
                });
              },
              child: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              color: Colors.deepPurple,
            ),
            ],
        ),
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
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
                 Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: new SizedBox(
                          width: 200.0,
                          height: 200.0,
                          child: (_imageFile!=null)?Image.file(
                            _imageFile,
                            fit: BoxFit.fill,
                          ):Image (image: AssetImage('assets/Profile_Image.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 30.0,
                      ),
                      onPressed: () {
                        pickImage();
                      },
                    ),
                  ),
                ],
              ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                     
                 TextFormField(
                        controller: _firstNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'First Name cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                            )),
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                       TextFormField(
                        controller: _middleNameController,
                        decoration: InputDecoration(
                            labelText: 'Middle name',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                            )),
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                       TextFormField(
                        controller: _lastNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Last Name cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                            )),
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      TextField(
                   controller: _dateOfBirthController,
                   decoration: InputDecoration( 
                   icon: Icon(Icons.calendar_today), 
                   labelText: "Date of Birth" 
                ),
                readOnly: true, 
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(1960), 
                      lastDate: DateTime(2022)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         _dateOfBirthController.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
             ),
                        DropdownButtonFormField<String>(
  focusColor:Colors.white,
  value: _idTypeController,
  elevation: 5,
  style: TextStyle(color: Colors.deepPurple),
  iconEnabledColor:Colors.deepPurple,
  items: <String>[
    'Voters ID','Passport','Ghana Card','NHIS Card',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.deepPurple),),
    );
  }).toList(),
  hint:Text(
    "Please select ID Type",
    style: TextStyle(
        color: Colors.deepPurple,
        fontSize: 16,
        fontWeight: FontWeight.w400),
  ),
  onChanged: (String value) {
    setState(() {
      _idTypeController = value;
    });
  },
),
          TextFormField(
          controller: _idNumberController,
          validator: (value) {
          if (value.isEmpty) {
          return 'ID Number cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'ID Number',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
                      

                      SizedBox(height: 20),
            Container(
              height: 40,
              width: 180,
            child: ElevatedButton(
          onPressed: () {Route route = MaterialPageRoute(builder: (c) => PayRenewLicense());
                   Navigator.pushReplacement(context, route);
          },
          child: Text('Click here to continue'),
          style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )
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

  void newVehicleRegistration() async {
    await uploadImageToFirebase();
        await DatabaseManager().vehicleRegistrationData(_dateOfPurchaseController.text, _engineNumberController.text, _vehicleColourController.text,
         _vehicleMakeController.text, _vehicleTypeController.text, _yearOfManufactureController.text, _dateOfBirthController.text, _firstNameController.text,
         _middleNameController.text, _lastNameController.text, _religionController.text, _phoneNumberController.text, _imageUrl, uid);
  }
    
}
