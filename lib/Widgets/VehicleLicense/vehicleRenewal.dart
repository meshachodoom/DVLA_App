import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile_demo/Homepage.dart';
import 'package:userprofile_demo/Widgets/VehicleLicense/renewVehicle.dart';

class VehicleRenewalScreen extends StatefulWidget {

  const VehicleRenewalScreen({ key }) : super(key: key);

  @override
  _VehicleRenewalScreenState createState() => _VehicleRenewalScreenState();
}

class _VehicleRenewalScreenState extends State<VehicleRenewalScreen> with WidgetsBindingObserver{
    Map<String, dynamic> userMap;
// final AuthenticationService _auth = AuthenticationService();


  bool isLoading = false;
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
  }

  void onSearch() async {
    Firestore _firestore = Firestore.instance;

    setState(() {
      isLoading = true;
      
    });

    await _firestore.collection('VehicleLicenseDetails').where("carNumber", isEqualTo: _search.text).getDocuments().then((value) {
    
      setState(() {
        userMap = value.documents[0].data;
        isLoading = false;
        
      });
      print(userMap);
    });
    
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(

         appBar:  AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
             Route route = MaterialPageRoute(builder: (c) => Homepage());
                   Navigator.pushReplacement(context, route);
          },
        ),
           title: Text("DVLA",
           style: TextStyle(fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
           ),
           centerTitle: true,
        ),
      
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.15,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search for Car Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    onSearch();
                  },
                  child: Text("Search"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                userMap != null
                    ? StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('VehicleLicenseDetails').where("carNumber", isEqualTo: _search.text).snapshots(),
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
              title: new Text(data['vehicleOwner']),
              subtitle: new Text(data['carNumber']),
              leading: CircleAvatar(
              child: Image(
                          image: AssetImage('assets/Profile_Image.png'),
                  ),
              ),
     onTap : (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => 
     UserRenewVehicleScreen(docid: document.documentID.toString())));                    
     },
      );   
          }).toList(),
        );
      },
     )
                    : Container(),
              ],
            ),      
    );
  }
}