import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'HomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _obscureText = true;
  bool _isLoggedIn = false;

  checkAuthentication() async
  {
    _auth.authStateChanges().listen((User? user) {
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

  login(String email1, String password1) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email1,
          password: password1

      );
      if (await FirebaseAuth.instance.currentUser != null) {
        // signed in
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()),
        );
      } else {
            print('Not signed in!');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
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
                          validator: (input) {
                            if (input == null || input
                                .trim()
                                .isEmpty)
                              return 'Enter Email';
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(input)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },

                          onChanged: (input) => _email = input,

                        ),
                      ),
                      Container(
                        child: new TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              icon: const Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: const Icon(Icons.lock))),
                          validator: (val) =>
                          val!.length < 6 || val == null
                              ? 'Password too short.'
                              : null,
                          onSaved: (val) => _password = val!,
                          obscureText: _obscureText,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors
                              .green, shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),

                          ),),
                          onPressed: () =>
                          {
                            //login(_email, _password),{
                            Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                            )
                          },

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