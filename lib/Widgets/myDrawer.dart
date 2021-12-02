import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:userprofile_demo/Widgets/VehicleLicense/vehicleRenewal.dart';
import 'package:userprofile_demo/Widgets/DriverLicense/DriverRenewal.dart';
import 'package:userprofile_demo/Widgets/Registration/driver.dart';
import 'package:userprofile_demo/users/test.dart';

class MyDrawer extends StatelessWidget {

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
                Text("Welcome ",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 35.0, fontFamily: "Signatra"),
                  ),
              ],
            ),
            ),
            SizedBox(height: 12.0),
            Container(
            child: Column(
              children: [
                // ListTile(
                //   leading: Icon(Icons.car_rental, color: Colors.deepPurple,),
                //   title: Text("Vehicle Registration", style: TextStyle(color: Colors.deepPurple),),
                //   onTap: (){
                //    Route route = MaterialPageRoute(builder: (c) => VehicleScreen());
                //    Navigator.pushReplacement(context, route);
                //   },
                // ),
                // Divider(height: 10.0, color: Colors.deepPurple, thickness: 6.0),

                ListTile(
                  leading: Icon(Icons.car_rental, color: Colors.deepPurple,),
                  title: Text("Vehicle License", style: TextStyle(color: Colors.deepPurple),),
                  onTap: (){
                   Route route = MaterialPageRoute(builder: (c) => VehicleRenewalScreen());
                   Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.deepPurple, thickness: 6.0),

                // ListTile(
                //   leading: Icon(Icons.app_registration, color: Colors.deepPurple,),
                //   title: Text("Driver License Registration", style: TextStyle(color: Colors.deepPurple),),
                //   onTap: (){
                //    Route route = MaterialPageRoute(builder: (c) => DriverScreen());
                //    Navigator.pushReplacement(context, route);
                //   },
                // ),
                // Divider(height: 10.0, color: Colors.deepPurple, thickness: 6.0),

                ListTile(
                  leading: Icon(Icons.person_pin_circle, color: Colors.deepPurple,),
                  title: Text("Driver License Renewal", style: TextStyle(color: Colors.deepPurple),),
                  onTap: (){
                   Route route = MaterialPageRoute(builder: (c) => DriverRenewalScreen());
                   Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.deepPurple, thickness: 6.0),

                 ListTile(
                  leading: Icon(Icons.help_center, color: Colors.deepPurple,),
                  title: Text("Help", style: TextStyle(color: Colors.deepPurple),),
                  onTap: (){
                  // Route route = MaterialPageRoute(builder: (c) => MyHomePage());
                  // Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.deepPurple, thickness: 6.0)
              ],
            ),
            ),
        ],
      ),
    );
  } 
}

