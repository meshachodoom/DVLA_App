import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:userprofile_demo/Admin/adminHomepage.dart';
import 'package:userprofile_demo/main.dart';


class AdminLoginScreen extends StatefulWidget{
  @override
    _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen>
{
   final _key = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
       return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Admin Login',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value.isEmpty){
                            return 'Username cannot be empty';
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.deepPurple)),
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(height: 50,
                          width: 250,
                          child: ElevatedButton(
           child: Text('Login'),
           style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
           onPressed: () {
             if(_usernameController.value.text == "admin" && _passwordController.value.text == "admin"){
            Route route = MaterialPageRoute(builder: (c) => AdminHomepage());
            Navigator.pushReplacement(context, route); 
             }
             else{
                        showDialog(context: context,builder: (BuildContext context) {
                return AlertDialog(
                content: new Text("Invalid username or password"),
                actions: <Widget>[
                ElevatedButton(
                child: Text("Ok"),
                style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,),
                onPressed: () {
                Navigator.of(context).pop(); 
                
            }
      ),
       ],
         );
          },
           );
             }
           },
           
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        child: Text('Login as client'),
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        textColor: Colors.deepPurple,
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}