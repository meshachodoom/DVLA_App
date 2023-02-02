import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paystack_manager/paystack_pay_manager.dart';
import 'package:userprofile_demo/DatabaseManager/DatabaseManager.dart';
import 'package:userprofile_demo/Homepage.dart';
import 'package:userprofile_demo/Success/success.dart';
import 'package:intl/intl.dart';

class DriverScreen extends StatefulWidget {
  final String docid;

  const DriverScreen({ key, this.docid }) : super(key: key);
  @override
  _DriverScreenState createState() => _DriverScreenState(docid);
}

class _DriverScreenState extends State<DriverScreen> {
  String docids;
  _DriverScreenState(this.docids);

  //TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _middlenameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  String _idTypeController;// = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  String uid;

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
      body:  SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                   child: Column(
                    children: [
                TextFormField(
                  controller: _firstnameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'First Name cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                            )),
                        style: TextStyle(color: Colors.deepPurple),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _middlenameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Middle Name cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                            labelText: 'Middle Name',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                            )),
                        style: TextStyle(color: Colors.deepPurple),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _lastnameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Last Name cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                            )),
                        style: TextStyle(color: Colors.deepPurple),
                ),
                SizedBox(height: 15),
                TextField(
                   controller: _dateOfBirthController,
                   decoration: InputDecoration( 
                   icon: Icon(Icons.calendar_today), 
                   labelText: "Date of Birth" 
                ),
                readOnly: true, 
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(1960), 
                      lastDate: DateTime(2022)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         _dateOfBirthController.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
             ),
                        DropdownButtonFormField<String>(
  focusColor:Colors.white,
  value: _idTypeController,
  elevation: 5,
  style: TextStyle(color: Colors.deepPurple),
  iconEnabledColor:Colors.deepPurple,
  items: <String>[
    'Voters ID','Passport','Ghana Card','NHIS Card',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.deepPurple),),
    );
  }).toList(),
  hint:Text(
    "Please select ID Type",
    style: TextStyle(
        color: Colors.deepPurple,
        fontSize: 16,
        fontWeight: FontWeight.w400),
  ),
  onChanged: (String value) {
    setState(() {
      _idTypeController = value;
    });
  },
),
          TextFormField(
          controller: _idNumberController,
          validator: (value) {
          if (value.isEmpty) {
          return 'ID Number cannot be empty';
          } else
          return null;
          },
          decoration: InputDecoration(
          labelText: 'ID Number',
          labelStyle: TextStyle(
          color: Colors.deepPurple,
          )),
          style: TextStyle(color: Colors.deepPurple),
          ),
                SizedBox(height: 25),
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
              ]
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
                "value": "",
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
    
    //await uploadImageToFirebase();
        await DatabaseManager().newDriverData(_firstnameController.text, _middlenameController.text, _lastnameController.text, _dateOfBirthController.text,
        _idTypeController, _idNumberController.text, uid);
  }

  void _onPaymentSuccessful(Transaction transaction) {
    print('Transaction succesful');
    print(
        "Transaction message ==> ${transaction.message}, Ref ${transaction.refrenceNumber}");
        Route route = MaterialPageRoute(builder: (c) => Success());
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
