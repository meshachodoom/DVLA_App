import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userprofile_demo/Services/AuthenticationService.dart';
import 'package:userprofile_demo/main.dart';



class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<FormState>();
  RegExp _digitRegex = RegExp("[0-9]+");

  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
      child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      SizedBox(height: 55),
                      Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 35),
                      TextFormField(
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z-]+|\s"))],
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
                      SizedBox(height: 25),
                      TextFormField(
                         inputFormatters: [WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z-]+|\s"))],
                        controller: _surnameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Surname cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                            labelText: 'Surname',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                            )),
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value.isEmpty || !_digitRegex.hasMatch(value)) {
                            return 'Phone Number cannot be empty';
                          }
                          else if(value.length != 10){
                             return 'Phone Number should be 10 digits';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                            )),
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          else if(!value.contains('@')){
                            return 'Email address is not valid';
                          }else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.deepPurple)),
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                          return 'Password cannot be empty';
                          }
                            else if(value.length <6){
                              return 'Password must be at least 6 characters long';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.deepPurple)),
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                            child: Text('Sign Up'),
                             style: ElevatedButton.styleFrom(
                               primary: Colors.deepPurple,
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                             ),
                            onPressed: () {
                              if (_key.currentState.validate()) {
                      
                                createUser();
                              }
                            },
                          ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                            child: Text('Cancel'),  style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple, 
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  void createUser() async {
    dynamic result = await _auth.createNewUser(
        _firstnameController.text,_surnameController.text, _emailController.text.trim(), _passwordController.text,_phoneNumberController.text,);
    if (result == null) {
      showDialog(context: context,builder: (BuildContext context) {
           return AlertDialog(
           content: new Text("Email already exists"),
           actions: <Widget>[
           ElevatedButton(
           child: Text("Ok"),
           style: ElevatedButton.styleFrom(
           primary: Colors.deepPurple,),
           onPressed: () {
                Navigator.pop(context); 
          },
      ),
       ],
         );
          },
           );
    } else {
     showDialog(context: context,builder: (BuildContext context) {
           return AlertDialog(
           content: new Text("Registration successful"),
           actions: <Widget>[
           ElevatedButton(
           child: Text("Ok"),
           style: ElevatedButton.styleFrom(
           primary: Colors.deepPurple,),
           onPressed: () {
                  Route route = MaterialPageRoute(builder: (c) => LoginScreen());
                Navigator.pushReplacement(context, route); 
          },
      ),
       ],
         );
          },
           );
    }
  }
}
