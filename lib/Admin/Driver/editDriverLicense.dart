import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userprofile_demo/Admin/Driver/driverLicenseList.dart';

class EditDriverScreen extends StatefulWidget {
  final String docid;

  const EditDriverScreen({key, this.docid}) : super(key: key);

  @override
  _EditDriverScreenState createState() => _EditDriverScreenState(docid);
}

class _EditDriverScreenState extends State<EditDriverScreen> {
  
  String docids;
  _EditDriverScreenState(this.docids);

   final _key = GlobalKey<FormState>();

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _middlenameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _licenseClassController = TextEditingController();
  TextEditingController _dateOfIssueController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _licenseNumberController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _referenceNumberController = TextEditingController();
  String imageUrl;
  String uid;

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
    imageUrl = await (await task.onComplete).ref.getDownloadURL();
  }
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

  Future<void> updateData() async {
    await uploadImageToFirebase();
      await Firestore.instance.collection('userDetails').document('$docids').updateData({
        "firstName": _firstnameController.text, "middleName": _middlenameController.text, "lastName": _lastnameController.text, "dateOfBirth": _dateOfBirthController.text,
        "licenseClass": _licenseClassController.text, "dateOfIssue": _dateOfIssueController.text, "expiryDate": _expiryDateController.text,  "licenseNumber": _licenseNumberController.text,
        "nationality": _nationalityController.text, "referenceNumber": _referenceNumberController.text, "imageUrl": imageUrl }).
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
             Route route = MaterialPageRoute(builder: (c) => AdminHomeScreen());
                   Navigator.pushReplacement(context, route);
          },
        ),
           title: Text("Edit Profile",
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
                  'Edit Personal Details',
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
                          ): Image.network(imageUrl.toString() ??AssetImage('assets/Profile_Image.png'),
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
          controller: _firstnameController,
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
          controller: _middlenameController,
          decoration: InputDecoration(
          labelText: 'Middle Name',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
          controller: _lastnameController,
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
          TextFormField(
          controller: _dateOfBirthController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Date of Birth cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Date of Birth',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
   TextFormField(
          controller: _licenseClassController,
          validator: (value) {
          if (value.isEmpty) {
          return 'License Class cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'License Class',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
          controller: _dateOfIssueController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Date of Issue cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Date of Issue',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
          controller: _expiryDateController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Expiry Date cannot be empty';
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
          controller: _licenseNumberController,
          validator: (value) {
          if (value.isEmpty) {
          return 'License Number cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'License Number',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
          controller: _nationalityController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Nationality cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Nationality',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
          controller: _referenceNumberController,
          validator: (value) {
          if (value.isEmpty) {
          return 'Reference Number cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'Reference Number',
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
           child: Text('Update'),
           style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
           onPressed: () {
           if (_key.currentState.validate()) {
           
           updateData();
           showDialog(context: context,builder: (BuildContext context) {
                return AlertDialog(
                //title: new Text("Edit User Details"),
                content: new Text("User Details updated successfully"),
                actions: <Widget>[
                ElevatedButton(
                child: Text("Ok"),
                style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,),
                onPressed: () {
                Route route = MaterialPageRoute(builder: (c) => AdminHomeScreen());
                   Navigator.pushReplacement(context, route);  
            }
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