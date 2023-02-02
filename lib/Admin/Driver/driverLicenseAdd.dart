import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userprofile_demo/Admin/Driver/driverLicenseList.dart';
import 'package:intl/intl.dart';
import 'package:userprofile_demo/DatabaseManager/DatabaseManager.dart';

class AddDriverLicense extends StatefulWidget {
  const AddDriverLicense({ key }) : super(key: key);

  @override
  _AddDriverLicenseState createState() => _AddDriverLicenseState();
}

class _AddDriverLicenseState extends State<AddDriverLicense> {
   final _key = GlobalKey<FormState>();
   

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  String _licenseClassController;
  String _imageUrl;
  TextEditingController _dateOfIssueController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _licenseNumberController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _referenceNumberController = TextEditingController();

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
    _imageUrl = await (await task.onComplete).ref.getDownloadURL();
  }

  @override
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
                  'Personal Details',
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
          inputFormatters: [WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z-]+|\s"))],
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
          inputFormatters: [WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z-]+|\s"))],
          controller: _middleNameController,
          decoration: InputDecoration(
          labelText: 'Middle Name',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
          inputFormatters: [WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z-]+|\s"))],
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
          TextFormField(
            validator: (value){
            if (value.isEmpty) {
          return 'Date of Birth cannot be empty';
          } else
          return null;
          },
          controller: _dateOfBirthController,
          decoration: InputDecoration( 
          prefixIcon: Icon(Icons.calendar_today), 
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
           print(pickedDate);  
           String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
            print(formattedDate); 
                      setState(() {
                         _dateOfBirthController.text = formattedDate;  
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
            ),
  DropdownButtonFormField<String>(
  validator: (value) => value == null
                    ? 'License class cannot be empty' : null,
  focusColor:Colors.deepPurple,
  value: _licenseClassController,
  elevation: 5,
  style: TextStyle(color: Colors.deepPurple),
  iconEnabledColor:Colors.black,
  items: <String>[
    'A','B','C','D','E','F',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.deepPurple),),
    );
  }).toList(),
  hint:Text(
    "Please select License Class",
    style: TextStyle(
        color: Colors.deepPurple,
        fontSize: 16,
        fontWeight: FontWeight.w400),
  ),
  onChanged: (String value) {
    setState(() {
      _licenseClassController = value;
    });
  },
),
 TextFormField(
    validator: (value){
            if (value.isEmpty) {
          return 'Date of Issue cannot be empty';
          } else
          return null;
          },
          controller: _dateOfIssueController,
          decoration: InputDecoration( 
          prefixIcon: Icon(Icons.calendar_today), 
          labelText: "Date of Issue" 
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
                         _dateOfIssueController.text = formattedDate;  
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
            ),
          TextFormField(
            validator: (value){
            if (value.isEmpty) {
          return 'Expiry Date cannot be empty';
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
          lastDate: DateTime(2060)
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
           child: Text("Save details"),
           style: ElevatedButton.styleFrom(
           primary: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
           onPressed: () {
           if (_key.currentState.validate()) {
           renewDriverLicense();
           showDialog(context: context,builder: (BuildContext context) {
           return AlertDialog(
           content: new Text("User added successfully"),
           actions: <Widget>[
           ElevatedButton(
           child: Text("Ok"),
           style: ElevatedButton.styleFrom(
           primary: Colors.deepPurple,),
           onPressed: () {
           Route route = MaterialPageRoute(builder: (c) => AdminHomeScreen());
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
  void renewDriverLicense() async {
      await uploadImageToFirebase();
        await DatabaseManager().renewDriverLicenseData(_firstNameController.text,_middleNameController.text, _lastNameController.text,_dateOfBirthController.text, 
        _licenseClassController, _imageUrl, _dateOfIssueController.text, _expiryDateController.text, _licenseNumberController.text, _nationalityController.text, _referenceNumberController.text, uid);
  }
}