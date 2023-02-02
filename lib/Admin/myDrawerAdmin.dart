import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:userprofile_demo/Admin/Driver/driverLicenseList.dart';
import 'package:userprofile_demo/Admin/Vehicle/vehicleLicenseList.dart';
import 'package:userprofile_demo/Admin/_Messaging/messaging.dart';


class MyDrawerAdmin extends StatelessWidget {

  @override

  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  elevation: 8.0,
                  child: Container(
                    height: 160.0,
                    width: 160.0,
                    child: Image(
                          image: AssetImage('assets/Profile_Image.png'),
                        ),
                    ),
                ),
                SizedBox(height: 10.0,),
                Text("Welcome Admin",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 35.0, fontFamily: "Signatra"),
                  ),
              ],
            ),
            ),
            SizedBox(height: 12.0),
            Container(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.car_rental, color: Colors.deepPurple,),
                  title: Text("Vehicle License", style: TextStyle(color: Colors.deepPurple),),
                  onTap: (){
                   Route route = MaterialPageRoute(builder: (c) => VehicleLicenseList());
                   Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.deepPurple, thickness: 6.0),

                ListTile(
                  leading: Icon(Icons.person_pin, color: Colors.deepPurple,),
                  title: Text("Driver License", style: TextStyle(color: Colors.deepPurple),),
                  onTap: (){
                   Route route = MaterialPageRoute(builder: (c) =>  AdminHomeScreen());
                   Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.deepPurple, thickness: 6.0),

                ListTile(
                  leading: Icon(Icons.person_pin, color: Colors.deepPurple,),
                  title: Text("Send Message", style: TextStyle(color: Colors.deepPurple),),
                  onTap: (){
                   Route route = MaterialPageRoute(builder: (c) =>  AdminMessaging());
                   Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.deepPurple, thickness: 6.0),
              ],
            ),
            ),
        ],
      ),
    );
  } 
}

