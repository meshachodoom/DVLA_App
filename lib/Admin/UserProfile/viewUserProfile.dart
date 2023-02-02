import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile_demo/Admin/UserProfile/userProfileList.dart';

class ViewUserProfile extends StatefulWidget {
  final String docid;

  const ViewUserProfile({key, this.docid}) : super(key: key);

  @override
  _ViewUserProfileState createState() => _ViewUserProfileState(docid);
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  String docids;
  _ViewUserProfileState(this.docids);

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String uid;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      await Firestore.instance
          .collection('profileInfo')
          .document('$docids')
          .get()
          .then((ds) {
        if (ds.exists) {
          setState(() {
            _firstnameController.text = ds.data['firstname'];
            _surnameController.text = ds.data['surname'];
            _emailController.text = ds.data['email'];
            _phoneNumberController.text = ds.data['phoneNumber'];
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
            Route route = MaterialPageRoute(builder: (c) => UserProfileList());
            Navigator.pushReplacement(context, route);
          },
        ),
        title: Text(
          "User Profile",
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontFamily: "Signatra"),
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
                                    child: Text('First name',
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16.0)),
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
                        ]),
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
                                    child: Text('Surname',
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16.0)),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(_surnameController.text,
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
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
                                    child: Text('Email',
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16.0)),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(_emailController.text,
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
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
                                    child: Text('Phone Number',
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16.0)),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(_phoneNumberController.text,
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
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
