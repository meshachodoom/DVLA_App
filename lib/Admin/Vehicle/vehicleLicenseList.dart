import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:userprofile_demo/Admin/Vehicle/editVehicleLicense.dart';
import 'package:userprofile_demo/Admin/Vehicle/addVehicleLicense.dart';
import 'package:userprofile_demo/Admin/Vehicle/viewVehicleLicense.dart';
import 'package:userprofile_demo/Admin/adminHomepage.dart';
import 'package:userprofile_demo/Admin/myDrawerAdmin.dart';

class VehicleLicenseList extends StatefulWidget {
  const VehicleLicenseList({ key }) : super(key: key);

  @override
  _VehicleLicenseListState createState() => _VehicleLicenseListState();
}

class _VehicleLicenseListState extends State<VehicleLicenseList> {
  TextEditingController _searchController = TextEditingController();
  String name="";

  final Stream<QuerySnapshot> _usersStream = Firestore.instance.collection('VehicleLicenseDetails').orderBy('vehicleOwner', descending: false).snapshots();
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
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
                  // onSearch();
                  // return buildSearch();
                 // _search();
                },
              )
            ],
          ),
              ),
        
         drawer: MyDrawerAdmin(),
        backgroundColor: Colors.white,
     body: 
     StreamBuilder<QuerySnapshot>(
      stream: (name != "" && name != null)
            ? Firestore.instance
                .collection('VehicleLicenseDetails')
                .orderBy('vehicleOwner')
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
           Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search)
              ),
            ),
          );
            return new ListTile(
              title: new Text(data['vehicleOwner']),
              subtitle: new Text(data['carNumber']),
              leading: CircleAvatar(
              child: Image(
                          image: AssetImage('assets/Profile_Image.png'),
                  ),
              ),
              trailing: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => 
              EditVehicleLicense(docid: document.documentID.toString())));
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
             await db.collection('VehicleLicenseDetails').document(document.documentID).delete();
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
     ViewVehicleLicense(docid: document.documentID.toString())));                    
     },
      );   
          }).toList(),
        );
      },
     ),
     floatingActionButton: FloatingActionButton(
       backgroundColor: Colors.deepPurple,
        onPressed: () {
         Route route = MaterialPageRoute(builder: (c) =>  VehicleLicenseAdd());
         Navigator.pushReplacement(context, route);
        },
        child: Icon(Icons.person_add, color: Colors.white),
      ),
  
      
    );
  }
}