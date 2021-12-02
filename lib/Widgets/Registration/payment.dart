import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart' as db;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paystack_manager/paystack_pay_manager.dart';
import 'package:userprofile_demo/Homepage.dart';
import 'package:userprofile_demo/Success/success.dart';
import 'package:userprofile_demo/Widgets/Registration/success.dart';

class PayNewLicense extends StatefulWidget {
  final String docid;

  const PayNewLicense({ key, this.docid }) : super(key: key);
  @override
  _PayNewLicenseState createState() => _PayNewLicenseState(docid);
}

class _PayNewLicenseState extends State<PayNewLicense> {
  String docids;
  _PayNewLicenseState(this.docids);

   var carMake, carMakeModel;
  var setDefaultMake = true, setDefaultMakeModel = true;

  //TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();

   final _auth = FirebaseAuth.instance;
   String userEmail;
   String phone;
   FirebaseUser users;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
           leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
             Route route = MaterialPageRoute(builder: (c) => Homepage());
                   Navigator.pushReplacement(context, route);
          },
        ),
           title: Text("User Profile",
           style: TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: "Signatra"),
           ),
           centerTitle: true,
        ),
      body:  Center(
        child: SingleChildScrollView(
          child: Column(
           children: [
             SizedBox(
            //flex: 1,
            child: Center(
              child: StreamBuilder<db.QuerySnapshot>(
                stream: db.Firestore.instance
                    .collection('carMake')
                    .orderBy('name')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<db.QuerySnapshot> snapshot) {
                  // Safety check to ensure that snapshot contains data
                  // without this safety check, StreamBuilder dirty state warnings will be thrown
                  if (!snapshot.hasData) return Container();
                  // Set this value for default,
                  // setDefault will change if an item was selected
                  // First item from the List will be displayed
                  if (setDefaultMake) {
                    carMake = snapshot.data.documents[0].data['name'];
                    debugPrint('setDefault make: $carMake');
                  }
                  return DropdownButton(
                    isExpanded: false,
                    value: carMake,
                    items: snapshot.data.documents.map((value) {
                      return DropdownMenuItem(
                        value: value.data['name'],
                        child: Text('${value.data['name']}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      debugPrint('selected onchange: $value');
                      setState(
                        () {
                          debugPrint('make selected: $value');
                          // Selected value will be stored
                          carMake = value;
                          // Default dropdown value won't be displayed anymore
                          setDefaultMake = false;
                          // Set makeModel to true to display first car from list
                          setDefaultMakeModel = true;
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(
            //flex: 1,
            child: Center(
              child: carMake != null
                  ? StreamBuilder<db.QuerySnapshot>(
                      stream: db.Firestore.instance
                          .collection('cars')
                          .where('make', isEqualTo: carMake)
                          .orderBy("makeModel").snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<db.QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          debugPrint('snapshot status: ${snapshot.error}');
                          return Container(
                            child:
                            Text(
                                'snapshot empty carMake: $carMake makeModel: $carMakeModel'),
                          );
                        }
                        if (setDefaultMakeModel) {
                          carMakeModel = snapshot.data.documents[0].data['makeModel'];
                          debugPrint('setDefault makeModel: $carMakeModel');
                        }
                        return DropdownButton(
                          isExpanded: false,
                          value: carMakeModel,
                          items: snapshot.data.documents.map((value) {
                            debugPrint('makeModel: ${value.data['makeModel']}');
                            return DropdownMenuItem(
                              value: value.data['makeModel'],
                              child: Text(
                                '${value.data['makeModel']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            debugPrint('makeModel selected: $value');
                            setState(
                              () {
                                // Selected value will be stored
                                carMakeModel = value;
                                // Default dropdown value won't be displayed anymore
                                setDefaultMakeModel = false;
                              },
                            );
                          },
                        );
                      },
                    )
                  : Container(
                      child: Text('carMake null carMake: $carMake makeModel: $carMakeModel'),
                    ),
            ),
          ),
          SizedBox(height: 25),
              //mainAxisAlignment: MainAxisAlignment.center,
              //children: [
             ElevatedButton(
          onPressed: () {
            _checkPayment(); 
          }, 
          child: Text('Proceed to Payment'),
         style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )),
           ]    
        )
      )
      )
      );
  }

  void _checkPayment() async{
    
    String user =
            await _auth.currentUser().then((value) => userEmail = value.email);
              print(user);
    try {
            PaystackPayManager(context: context)
              ..setSecretKey("sk_test_7364461df5352cd4ca830865250d73a19f5cca0c")
              // ..setCompanyAssetImage(Image(image: NetworkImage("YOUR-IMAGE-URL")))
              ..setAmount(20000)
              ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
              ..setCurrency("GHS")
              ..setEmail(user)
              ..setFirstName("firstName")
              ..setLastName("lastName")
              ..setCountry("Ghana")
              ..setMetadata(
                {
                  "custom_fields": [
              {
                "value": carMakeModel,
                "display_name": _firstnameController.text,
                "variable_name": "Payment_to"
              }
            ]
          },
        )
        ..onSuccesful(_onPaymentSuccessful)
        ..onPending(_onPaymentPending)
        ..onFailed(_onPaymentFailed)
        ..onCancel(_onCancel)
        ..initialize();
    } catch (error) {
      print('Payment Error ==> $error');
    }
  }

  void _onPaymentSuccessful(Transaction transaction) {
    print('Transaction succesful');
    print(
        "Transaction message ==> ${transaction.message}, Ref ${transaction.refrenceNumber}");
        Route route = MaterialPageRoute(builder: (c) => SuccessRegistration());
        Navigator.pushReplacement(context, route);
  }

  void _onPaymentPending(Transaction transaction) {
    print('Transaction Pending');
    print("Transaction Ref ${transaction.refrenceNumber}");
  }

  void _onPaymentFailed(Transaction transaction) {
    print('Transaction Failed');
    print("Transaction message ==> ${transaction.message}");
  }

  void _onCancel(Transaction transaction) {
    print('Transaction Cancelled');
  }
}
