import 'package:flutter/material.dart';
import 'package:userprofile_demo/DatabaseManager/DatabaseManager.dart';
import 'package:userprofile_demo/Services/AuthenticationService.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();

  List userProfilesList = [];

  String userID = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchDatabaseList();
  }

  fetchUserInfo() async {
    //User getUser = FirebaseAuth.instance.currentUser;
    //userID = getUser.uid;
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  // updateData(String name, String gender, int score, String userID) async {
  //   await DatabaseManager().updateUserList(name, gender, score, userID);
  //   fetchDatabaseList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          actions: [
            RaisedButton(
              onPressed: () {
                openDialogueBox(context);
              },
              child: Icon(
                Icons.edit,
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
            )
          ],
        ),
        body: Container(
            child: ListView.builder(
                itemCount: userProfilesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(userProfilesList[index]['firstname']),
                      subtitle: Text(userProfilesList[index]['surname']),
                      leading: CircleAvatar(
                        child: Image(
                          image: AssetImage('assets/Profile_Image.png'),
                        ),
                      ),
                      trailing: Text('${userProfilesList[index]['phoneNumber']}'),
                    ),
                  );
                })));
  }

  openDialogueBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit User Details'),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: _firstnameController,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                  TextField(
                    controller: _genderController,
                    decoration: InputDecoration(hintText: 'Gender'),
                  ),
                  TextField(
                    controller: _scoreController,
                    decoration: InputDecoration(hintText: 'Score'),
                  )
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  //submitAction(context);
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  // submitAction(BuildContext context) {
  //   updateData(_firstnameController.text, _genderController.text,
  //       int.parse(_scoreController.text), userID);
  //   _firstnameController.clear();
  //   _genderController.clear();
  //   _scoreController.clear();
  // }
}
