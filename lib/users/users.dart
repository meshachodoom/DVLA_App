import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userprofile_demo/Admin/Driver/driverLicense.dart';

class UserDetailsScreen extends StatefulWidget{
    

  const UserDetailsScreen({key}) : super(key: key);
  @override 
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen>{
  //List userDetailsList = [];
  final Stream<QuerySnapshot> _usersStream = Firestore.instance.collection('userDetails').snapshots();


   @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
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
              title: new Text(data['firstName']),
              subtitle: new Text(data['lastName']),
              leading: CircleAvatar(
                        child: Image(
                          image: AssetImage('assets/Profile_Image.png'),
                        ),
                      ),
                      //trailing: Text('${userDetailsList[index]['Age']}'),
                      onTap : (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => 
                         DriverLicenseScreen(docid: document.documentID.toString(),)));
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => 
                        //  DriverLicenseScreen(docid: dataid.toString(),)));
                      } ,
            );
          }).toList(),
        );
      },
    ),
    );
  /*String docids;

   //List userProfilesList = [];
   List userDetailsList = [];
   //List profileInfoList = [];

  
   String userID = "";
 
  void initState() {
    super.initState();
    //fetchUserInfo();
    fetchDatabaseList();

  }

 /* fetchUserInfo() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    userID = getUser.uid;
  }*/

  fetchDatabaseList() async {
    
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        //profileInfoList = resultant;
        userDetailsList = resultant;
      });
    }
  }


  Widget build(BuildContext context){
    return Scaffold(
         body: Container(
            child: ListView.builder(
                itemCount: userDetailsList.length,
                //itemCount: profileInfoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(userDetailsList[index]['firstName']),
                      subtitle: Text(userDetailsList[index]['lastName']),
                      //title: Text(profileInfoList[index]['firstname']),
                      //subtitle: Text(profileInfoList[index]['surname']),
                      leading: CircleAvatar(
                        child: Image(
                          image: AssetImage('assets/Profile_Image.png'),
                        ),
                      ),
                      trailing: Text('${userDetailsList[index]['Age']}'),
                      onTap : (){
                        
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => 
                        //  DriverLicenseScreen(docid: dataid.toString(),)));
                      } ,
                      //trailing: Text('${profileInfoList[index]['Age']}'),
                    ),
                  );
                })));*/
  }
}