import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile_demo/Admin/UserProfile/viewUserProfile.dart';
import 'package:userprofile_demo/Admin/adminHomepage.dart';
import 'package:userprofile_demo/Admin/myDrawerAdmin.dart';

class UserProfileList extends StatefulWidget {
  const UserProfileList({key}) : super(key: key);

  @override
  _UserProfileListState createState() => _UserProfileListState();
}

class _UserProfileListState extends State<UserProfileList> {
  TextEditingController _searchController = TextEditingController();
  String name = "";

  final Stream<QuerySnapshot> _usersStream = Firestore.instance
      .collection('profileInfo')
      .orderBy('firstname', descending: false)
      .snapshots();

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
                 // controller: _searchController,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? Firestore.instance
                .collection('profileInfo')
                .orderBy('firstname')
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
            shrinkWrap: true,
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data;
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 30.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                ),
              );
              return new ListTile(
                title: new Text(data['firstname'] + " " + data['surname']),
                subtitle: new Text(data['email'] + ' ' + data['phoneNumber']),
                leading: CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/Profile_Image.png'),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUserProfile(
                              docid: document.documentID.toString())));
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
