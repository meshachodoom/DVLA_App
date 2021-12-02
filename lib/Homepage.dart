import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:userprofile_demo/Services/AuthenticationService.dart';
import 'package:userprofile_demo/Widgets/DriverLicense/DriverRenewal.dart';
import 'package:userprofile_demo/Widgets/VehicleLicense/vehicleRenewal.dart';
import 'package:userprofile_demo/Widgets/myDrawer.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userprofile_demo/main.dart';

double width;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "DVLA",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        actions: [
          RaisedButton(
            onPressed: () async {
                Route route = MaterialPageRoute(builder: (c) => LoginScreen());
                Navigator.pushReplacement(context, route);
                //await _auth.signOut().then((result) {
                 // Navigator.of(context).pop(true);
               // });
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            color: Colors.deepPurple,
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 350.0,
                width: double.infinity,
                child: Carousel(
                  images: [
                    AssetImage('assets/image1.jpg'),
                    AssetImage('assets/image2.jpg'),
                    AssetImage("assets/image3.jpg"),
                    AssetImage('assets/image4.jpg'),
                    // AssetImage("assets/Profile_Image.png"),
                    //AssetImage('assets/Logo_Black.png'),
                  ],
                  dotColor: Colors.white,
                  dotBgColor: Colors.transparent,
                  dotIncreasedColor: Colors.deepPurple,
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        Colors.deepPurple,
                        Colors.deepPurple
                      ]),
                    ),
                  ),
                ),
                GradientText("Headlines   ",
                    gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.deepPurple]),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center),
                Expanded(
                  child: Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        Colors.deepPurple,
                        Colors.deepPurple
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    launch(
                        'http://www.dvla.gov.gh/singlenews.php?news=35e995c107a71caeb833bb3b79f9f54781b33fa1');
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 25),
                    height: 80,
                    color: Colors.transparent,
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              child: Image.asset(
                                "assets/news.jpg",
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
                              "DVLA adjudged Best State Owned Enterprise (SOE) in Customer Experience",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.normal,
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
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    launch(
                        'http://www.dvla.gov.gh/singlenews.php?news=d02560dd9d7db4467627745bd6701e809ffca6e3');
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 25),
                    height: 80,
                    color: Colors.transparent,
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              child: Image.asset(
                                "assets/news1.jpg",
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
                              "DVLA CEO honoured with hall of fame for the transport sector",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.normal,
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
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    launch(
                        'http://www.dvla.gov.gh/singlenews.php?news=b4c96d80854dd27e76d8cc9e21960eebda52e962');
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 25),
                    height: 80,
                    color: Colors.transparent,
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              child: Image.asset(
                                "assets/news2.png",
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
                              "DVLA grabs best use of IT in service awards",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.normal,
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
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        Colors.deepPurple,
                        Colors.deepPurple
                      ]),
                    ),
                  ),
                ),
                GradientText("Services   ",
                    gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.deepPurple]),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center),
                Expanded(
                  child: Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        Colors.deepPurple,
                        Colors.deepPurple
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (c) => DriverRenewalScreen());
                    Navigator.pushReplacement(context, route);
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 25) / 2,
                    height: 100,
                    color: Colors.transparent,
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              child: Image.asset(
                                "assets/renewIcon.jpg",
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
                              "Renew Driver License",
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
                InkWell(
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (c) => VehicleRenewalScreen());
                    Navigator.pushReplacement(context, route);
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 25) / 2,
                    height: 100,
                    color: Colors.transparent,
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            width: 0,
                          ),
                          Flexible(
                            child: Text(
                              "Renew Vehicle License",
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(
        data['businessName'],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ))));
}
