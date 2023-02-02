import 'package:flutter/material.dart';
import 'package:userprofile_demo/Admin/Driver/driverLicenseList.dart';
import 'package:userprofile_demo/Admin/UserProfile/userProfileList.dart';
import 'package:userprofile_demo/Admin/Vehicle/vehicleLicenseList.dart';
import 'package:userprofile_demo/Admin/_Messaging/messaging.dart';
import 'package:userprofile_demo/Admin/myDrawerAdmin.dart';
import 'package:userprofile_demo/main.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({key}) : super(key: key);

  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "DVLA",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        actions: [
          RaisedButton(
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => LoginScreen());
              Navigator.pushReplacement(context, route);
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            color: Colors.deepPurple,
          ),
        ],
      ),
      drawer: MyDrawerAdmin(),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (c) => AdminHomeScreen());
                Navigator.pushReplacement(context, route);
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 25),
                height: 100,
                color: Colors.transparent,
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          child: Image.asset(
                            "assets/Profile_Image.png",
                            // fit: BoxFit.fill,
                            width: 70,
                            height: 150,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "List of Registered Drivers",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (c) => VehicleLicenseList());
                Navigator.pushReplacement(context, route);
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 25),
                height: 100,
                color: Colors.transparent,
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          child: Image.asset(
                            "assets/vehicleIcon.png",
                            // fit: BoxFit.fill,
                            width: 70,
                            height: 150,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "List of Registered Vehicles",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (c) => AdminMessaging());
                Navigator.pushReplacement(context, route);
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 25),
                height: 100,
                color: Colors.transparent,
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          child: Icon(Icons.message_outlined),
                          // fit: BoxFit.fill,
                          width: 70,
                          height: 150,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "Send Message to client",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Route route =
                    MaterialPageRoute(builder: (c) => UserProfileList());
                Navigator.pushReplacement(context, route);
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 25),
                height: 100,
                color: Colors.transparent,
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipOval(
                        child: Container(
                          child: Image.asset(
                            "assets/Profile_Image.png",
                            // fit: BoxFit.fill,
                            width: 70,
                            height: 150,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "List of Users",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
