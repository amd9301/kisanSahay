import 'package:flutter/material.dart';
import 'package:kisan_sahay/HomePage.dart';

import 'Login.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _confirmPassword = '';

  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      print('Everything looks good!');
      print(_userEmail);
      print(_userName);
      print(_password);
      print(_confirmPassword);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Container(

            color:Color(0xfff6fef6),
            alignment: Alignment.center,

              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                child:
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 20.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                child:Text('Register Now ',style: TextStyle(fontSize: 27.0,color: Colors.green[800]),)
                            ),
                            SizedBox(height: 20.0),
                            // Email
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email',prefixIcon: Icon(Icons.email)),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Please enter your email address';
                                }
                                // Check if the entered email has the right format
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                // Return null if the entered email is valid
                                return null;
                              },
                              onChanged: (value) => _userEmail = value,
                            ),

                            /// username
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Username',prefixIcon: Icon(Icons.supervised_user_circle_outlined)),

                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'This field is required';
                                }
                                if (value.trim().length < 4) {
                                  return 'Username must be at least 4 characters in length';
                                }
                                // Return null if the entered username is valid
                                return null;
                              },
                              onChanged: (value) => _userName = value,
                            ),


                            /// Password
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Password',prefixIcon: Icon(Icons.lock)),
                              obscureText: true,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'This field is required';
                                }
                                if (value.trim().length < 8) {
                                  return 'Password must be at least 8 characters in length';
                                }
                                // Return null if the entered password is valid
                                return null;
                              },
                              onChanged: (value) => _password = value,
                            ),


                            /// Confirm Password
                            TextFormField(
                              decoration:
                              InputDecoration(labelText: 'Confirm Password',prefixIcon: Icon(Icons.lock)),
                              obscureText: true,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return 'This field is required';
                                }

                                if (value != _password) {
                                  return 'Confimation password does not match the entered password';
                                }

                                return null;
                              },
                              onChanged: (value) => _confirmPassword = value,
                            ),
                            SizedBox(height: 18),
                            Container(
                              child: ElevatedButton(
                                  onPressed: _trySubmitForm,
                                  style: ElevatedButton.styleFrom(primary: Colors.green,shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(20.0),

                                  ),),
                                  child: Text('SIGN UP',style: TextStyle(
                                      fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white
                                  ),)),

                        ),
                  ],),

              ),
            ),

    )),
        ),
      ));

  }
}
