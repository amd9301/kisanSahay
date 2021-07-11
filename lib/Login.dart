import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'HomePage.dart';
import 'package:kisan_sahay/pages/verify.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loginfail =false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _obscureText = true;
  bool _isLoggedIn=false;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<void> signIn() async {
    // Trigger the authentication flow
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);

      // if(_auth.currentUser!.emailVerified==true){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      // }
      // else{
      //   try {
      //     // await _auth.currentUser!.sendEmailVerification();
      //     print("!!!!!");
      //   } catch (e) {
      //     print("An error occured while trying to send email        verification");
      //     print(e);
      //   }
        setState(() {
          // print("!@#**************************************");
          loginfail = false;
        });
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => Verify()),
      //   );
      // }
    }

    catch(e){
      setState(() {
        print("!@#**************************************");
        loginfail = true;
      });
    }




  }
  checkAuthentication() async
  {
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {

        print('User is signed in!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });

    @override
    void initState() {
      super.initState();
      this.checkAuthentication();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,
      //physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(

            children: [
              SizedBox(height: 20.0),

              Container(
                height: 300.0,
                child: Image(image: AssetImage("assets/images/login.jfif"),
                  fit: BoxFit.contain,),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      Container(

                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)
                          ),
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
                          onChanged: (value) => _email = value,

                        ),
                      ),
                      Container(
                        child: new TextFormField(
                          decoration:  InputDecoration(
                              labelText: 'Password',
                              errorText: loginfail ? 'email or password doesnt match' : null,
                              icon: const Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: const Icon(Icons.lock))),
                          validator: (val) =>
                          val!.length < 6 || val == null
                              ? 'Password too short.'
                              : null,
                          onChanged: (val) => _password = val,
                          obscureText: _obscureText,
                        ),
                      ),


                      SizedBox(height: 20.0),
                      ElevatedButton(
                          onPressed:signIn,
                          style: ElevatedButton.styleFrom(primary: Colors
                              .green, shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),

                          ),),

                          child: Text('SUBMIT', style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),

            ],
          ),
        ),
      ),
    );
  }
}