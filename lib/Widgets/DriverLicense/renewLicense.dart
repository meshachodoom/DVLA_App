import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userprofile_demo/Widgets/DriverLicense/DriverRenewal.dart';
import 'package:userprofile_demo/Widgets/DriverLicense/payRenew.dart';

class UserDriverRenewal extends StatefulWidget {
  final String docid;

  const UserDriverRenewal({ key, this.docid }) : super(key: key);

  @override
  _UserDriverRenewalState createState() => _UserDriverRenewalState(docid);
}

class _UserDriverRenewalState extends State<UserDriverRenewal> {
 File _imageFile;

  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

   Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot =  (await uploadTask) as StorageTaskSnapshot;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
  }

  String docids;
  _UserDriverRenewalState(this.docids);

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _middlenameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _licenseNumberController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _licenseClassController = TextEditingController();
  TextEditingController _dateOfIssueController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _referenceNumberController = TextEditingController();
  String imageUrl;
  
  @override
  void initState(){
    super.initState();
    _fetchUserData();
  }

 void _fetchUserData() async {
    try{
      await Firestore.instance.collection('userDetails').document('$docids').get().then((ds){
        if(ds.exists){
          setState((){
            _firstnameController.text = ds.data['firstName'];
            _middlenameController.text = ds.data['middleName'];
            _lastnameController.text = ds.data['lastName'];
            _dateOfBirthController.text = ds.data['dateOfBirth'];
            _licenseClassController.text = ds.data['licenseClass'];
            _dateOfIssueController.text = ds.data['dateOfIssue'];
            _expiryDateController.text = ds.data['expiryDate'];
            _licenseNumberController.text = ds.data['licenseNumber'];
            _nationalityController.text = ds.data['nationality'];
            _referenceNumberController.text = ds.data['referenceNumber'];
            imageUrl = ds.data['imageUrl'];
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
             Route route = MaterialPageRoute(builder: (c) => DriverRenewalScreen());
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'License Details',
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
                          ): Image.network(imageUrl.toString() ??AssetImage('assets/Profile_Image.png'),
                            fit: BoxFit.fill,
                          ),
                          
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
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
                            child: Text('First Name',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_firstnameController.text,
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
                            child: Text('Middle Name',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_middlenameController.text,
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
                            child: Text('Lastname',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_lastnameController.text,
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
                            child: Text('Date Of Birth',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_dateOfBirthController.text,
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
                            child: Text('License Class',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_licenseClassController.text,
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
                            child: Text('Date of Issue',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_dateOfIssueController.text,
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
                            child: Text('License Number',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_licenseNumberController.text,
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
                            alignment: Alignment.centerLeft,
                            child: Text('Nationality',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_nationalityController.text,
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
                            child: Text('Reference Number',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0)),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(_referenceNumberController.text,
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
            Container(
              height: 40,
              width: 180,
            child: ElevatedButton(
          onPressed: () {Route route = MaterialPageRoute(builder: (c) => PayRenewLicense());
                   Navigator.pushReplacement(context, route);
          },
          child: Text('Request renewal'),
          style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )
                ),
            ),
              ],
              
                )
                
        ),
              ]
          )
         )
         )
         
        );        
    
  }
}