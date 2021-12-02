import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:userprofile_demo/Admin/_Messaging/successMessage.dart';
import 'package:userprofile_demo/Admin/adminHomepage.dart';

class AdminMessaging extends StatefulWidget {
  const AdminMessaging({key}) : super(key: key);

  @override
  _AdminMessagingState createState() => _AdminMessagingState();
}

class _AdminMessagingState extends State<AdminMessaging> {
  TextEditingController _controllerPeople = TextEditingController();
  TextEditingController _controllerMessage = TextEditingController()..text = 'Dear valued customer!. Your renewal request has been accepted. Please come to the [location] with your original license on [date] between 8:00 AM and 12:00 PM';

  final _key = GlobalKey<FormState>();
  RegExp _digitRegex = RegExp("[0-9]+");

  TwilioFlutter twilioFlutter;
  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'ACdac079cb52a2be1fb482cfff6ca290d7',
        authToken: 'd17bc7afa4bff79e7e3a9301f7c59148',
        twilioNumber: '+13475149644');
    super.initState();
  }

  void sendSms() async {
    twilioFlutter.sendSMS(
        toNumber: _controllerPeople.text, //' +233202879841',
        messageBody: _controllerMessage
            .text); //'Hii everyone this is a demo of\nflutter twilio sms.');
  }

  void getSms() async {
    var data = await twilioFlutter.getSmsList();
    print(data);
    await twilioFlutter.getSMS('***************************');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => AdminHomepage());
              Navigator.pushReplacement(context, route);
            },
          ),
          title: Text(
            "DVLA",
            style: TextStyle(
                fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
          ),
          centerTitle: true,
        ),
        body: Container(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.people),
                    title: TextFormField(
                      controller: _controllerPeople,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty || !_digitRegex.hasMatch(value)) {
                          return 'Phone Number cannot be empty';
                        } else
                          return null;
                      },
                      decoration:
                          InputDecoration(labelText: "Add Phone Number"),
                      onChanged: (String value) => setState(() {}),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.message_outlined),
                    title: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLines: 8,
                            controller: _controllerMessage,
                            //initialValue:"Dear [name]! Please come to the [location] with your original license on [date] between 8:00 AM and 12:00 PM" ,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Text Message cannot be empty';
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Enter message here",
                                border: InputBorder.none),
                          ),
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        sendSms();
                        Route route = MaterialPageRoute(
                            builder: (c) => AdminSuccessMessage());
                        Navigator.pushReplacement(context, route);
                      }
                    },
                    child: Text("Send Sms"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
