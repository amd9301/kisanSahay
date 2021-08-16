import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'package:kisan_sahay/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'Login.dart';
import 'package:geocoder/geocoder.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  String _userEmail = '';
  String _userName = '';
  String _password = '';
  double _latitide =1;
  double _longitude =1;
  String _confirmPassword = '';
  String _phoneNo = '';
  Future<double> get_locatio() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _latitide= position.latitude;
    return position.longitude;
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      print('Everything looks good!');
      print(_userEmail);
      print(_userName);
      print(_password);
      print(_confirmPassword);
      _longitude= await get_locatio();
      print(_longitude);
      print(_latitide);
      UserCredential user= await _auth.createUserWithEmailAndPassword(email: _userEmail,password: _password);
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      _auth.currentUser!.updateDisplayName(_userName);
      _auth.currentUser!.updatePhotoURL("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_mCyTdVerlZkBa4mPc5wDWUXmbGcIuxaN-1FJ1kJ8BS6rq7vrD1B4Rm33wgyRRTFccwQ&usqp=CAU");

      final coordinates = new Coordinates(_latitide, _longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      print("!!!!!!!!!!!!!!!");
      // print(first.locality);
     //print("subAdminArea"+first.subAdminArea);
     //  print(first.adminArea);
     //  print(first.postalCode);
      await users.doc(_auth.currentUser!.uid).set({
        'name':_userName,
        'email': _auth.currentUser!.email.toString(),
        'latitude':_latitide,
        'longitude':_longitude,
        'phoneNumber': _phoneNo,
        'rating': 1,
        'locality':first.locality,
        'postal':first.postalCode,
        'adress':first.addressLine,

      });
      // print(users.id.)
      try {
        await _auth.currentUser!.sendEmailVerification();
      } catch (e) {
        print("An error occurred while trying to send email verification");
        print(e);
      }
      _auth.signOut();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("Sign Up "),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
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
                            decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon:
                                InkWell(
                                  onTap:_toggle ,
                                  child: Icon(
                                    _obscureText
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                )
                            ),
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
                            InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon:
                                InkWell(
                                  onTap:_toggle ,
                                  child: Icon(
                                    _obscureText
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                )
                            ),
                            obscureText: true,
                            validator: (value) {
                              if(value!.isEmpty){
                                return 'This field is required';
                              }

                              if (value != _password) {
                                return "Passwords doesn't match";
                              }

                              return null;
                            },
                            onChanged: (value) => _confirmPassword = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(
                                labelText: 'Phone Number',
                                prefixIcon: Icon(Icons.phone)
                            ),
                            validator: (value) {
                              if(value!.isEmpty){
                                return 'This field is required';
                              }

                            },
                            onChanged: (value) => _phoneNo = value,
                          ),
                          SizedBox(height: 18),
                          Container(
                            child: ElevatedButton(
                                onPressed: _trySubmitForm,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,shape:
                                new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),

                                ),),
                                child: Text('SIGN UP',style: TextStyle(
                                    fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white
                                ),)),

                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have an account? ",
                                style: TextStyle(
                                    fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      new MaterialPageRoute(builder: (BuildContext context)=> new Login())
                                  );
                                },
                                child: Text(
                                  "Login here",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                )),
          ),
        ));

  }
}
