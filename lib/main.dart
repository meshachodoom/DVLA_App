import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userprofile_demo/Admin/adminLogin.dart';
import 'package:userprofile_demo/Homepage.dart';
import 'package:userprofile_demo/RegistrationScreen.dart';
import 'package:userprofile_demo/Services/AuthenticationService.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/homepage': (context) => Homepage(),

      },
    ));

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
 bool isLoading = true;
  final _key = GlobalKey<FormState>();

  final AuthenticationService _auth = AuthenticationService();
  

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
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
                            controller: _emailController,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Email address is not valid';
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(),
                                labelText: 'Email',
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
                         SizedBox(height: 20),
                          Container(
                            height: 50,
                            width: 250,
                            child: 
                              ElevatedButton(
                                child: Text('Login'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    
                                  ),
                                  onPressed: () {
                                  if (_key.currentState.validate()) {
                                    showLoaderDialog(context);
                                    signInUser();
                                    //Navigator.of(context).pop(); 
                                    }
                                },
                                ), 
              
                          ),
                          FlatButton(
                            child: Text('Not registerd? Sign up'),
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => RegistrationScreen(),
                                ),
                              );
                            },
                            textColor: Colors.deepPurple,
                          ),
                          FlatButton(
                            child: Text('Click here to Login as admin'),
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => AdminLoginScreen()
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
      ),
    );
  }

  void signInUser() async {
    dynamic authResult =
        await _auth.loginUser(_emailController.text.trim(), _passwordController.text.trim());
              if (authResult == null) {
               showDialog(context: context,builder: (BuildContext context) {
                return AlertDialog(
                content: new Text("Invalid email or password"),
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
              } else {
                _emailController.clear();
                _passwordController.clear();
                Navigator.pushNamed(context, '/homepage');
              }
            }

            showLoaderDialog(BuildContext context){
            AlertDialog alert=AlertDialog(
            content: new Row(
            children: [
            CircularProgressIndicator(),
            Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(
      context:context,
      builder:(BuildContext context){
        return alert;
      }
    );
  }
}