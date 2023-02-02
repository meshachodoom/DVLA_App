import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:userprofile_demo/Admin/Driver/driverLicense.dart';
import 'package:userprofile_demo/Admin/Driver/driverLicenseAdd.dart';
import 'package:userprofile_demo/Admin/Driver/editDriverLicense.dart';
import 'package:userprofile_demo/Admin/adminHomepage.dart';
import 'package:userprofile_demo/Widgets/DriverLicense/renewLicense.dart';


class AdminHomeScreen extends StatefulWidget{
 

  const AdminHomeScreen({key}) : super(key: key);
  @override
    _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  TextEditingController _searchController = TextEditingController();
  String name = "";

  Map<String, dynamic> userMap;

  final Stream<QuerySnapshot> _usersStream = Firestore.instance.collection('userDetails').orderBy('firstName', descending: false).snapshots();
  final db = Firestore.instance;

  @override
   
  Widget build(BuildContext context){

    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
             Route route = MaterialPageRoute(builder: (c) => AdminHomepage());
                   Navigator.pushReplacement(context, route);
          },
        ),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 4.0, bottom: 8.0, top: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search ",
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                     onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
          
                },
              )
            ],
          ),
              ),
        
         
        backgroundColor: Colors.white,
     body: StreamBuilder<QuerySnapshot>(
      stream: (name != "" && name != null)
            ? Firestore.instance
                .collection('userDetails')
                .orderBy('firstName')
                .startAt([name]).endAt([name + '\uf8ff']).snapshots()
            : _usersStream,  
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView( 
          children: snapshot.data.documents.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data;
            return new ListTile(
              title: new Text(data['firstName'] +" "+ data['lastName']),
              subtitle: new Text(data['licenseNumber']),
              leading: CircleAvatar(
              child: Image.network(
              data['imageUrl'] ??AssetImage('assets/Profile_Image.png'),
              fit: BoxFit.fill),
              ),
              trailing: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => 
              EditDriverScreen(docid: document.documentID.toString())));
              },
              icon: Icon(FontAwesomeIcons.pen,  color: Colors.deepPurple)),
              IconButton(onPressed: () {
              showDialog(context: context,builder: (BuildContext context) {
                return AlertDialog(
                title: new Text("Delete User"),
                content: new Text("Are you sure you want to delete this user?"),
                actions: <Widget>[
                ElevatedButton(
                child: Text("No"),
                style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,),
                onPressed: () {
                Navigator.of(context).pop(); 
            }
        ),
            SizedBox(width: 20),
              ElevatedButton(
            child: Text("Yes"),
            style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,),
            onPressed: () async{
             await db.collection('userDetails').document(document.documentID).delete();
             Navigator.of(context).pop();
            }
        ),
          ],
        );
      },
    );
     },
     icon: Icon(Icons.delete,  color: Colors.deepPurple),)
      ],
        ),
     onTap : (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => 
     DriverLicenseScreen(docid: document.documentID.toString())));                    
     },
      );   
          }).toList(),
        );
      },
     ),
     floatingActionButton: FloatingActionButton(
       backgroundColor: Colors.deepPurple,
        onPressed: () {
         Route route = MaterialPageRoute(builder: (c) =>  AddDriverLicense());
         Navigator.pushReplacement(context, route);
        },
        child: Icon(Icons.person_add, color: Colors.white),
      ),
  
    );
 
    }

    Widget buildSearch(){
      return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('userDetails').where("licenseNumber", isEqualTo: _searchController.text).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView( 
          shrinkWrap: true,
          children: snapshot.data.documents.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data;
            return new ListTile(
              title: new Text(data['firstName'] +" "+ data['lastName']),
              subtitle: new Text(data['licenseNumber']),
              leading: CircleAvatar(
              child: Image.network(
              data['imageUrl'] ??AssetImage('assets/Profile_Image.png'),
              fit: BoxFit.fill),
              ),
     onTap : (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => 
     UserDriverRenewal(docid: document.documentID.toString())));                    
     },
      );   
          }).toList(),
        );
      },
     );
    }

    
}
