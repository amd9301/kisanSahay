import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kisan_sahay/reset.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'package:kisan_sahay/pages/verify.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:translator/translator.dart';
import 'package:kisan_sahay/globals.dart' as globals;
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
  String terror='email or password doesnt match';
  String temail='email';
  String tpass='password';
  String tsubmit='submit';
  // final prefs = await SharedPreferences.getInstance();
  @override
  void initState()  {
    temail.translate(to: globals.lang).then((value){setState(() {temail=value.text;});});
    tpass.translate(to: globals.lang).then((value){setState(() {tpass=value.text;});});
    terror.translate(to: globals.lang).then((value){setState(() {terror=value.text;});});
    tsubmit.translate(to: globals.lang).then((value){setState(() {tsubmit=value.text;});});

    // sreg.translate(to: 'te');
    // sphnone.translate(to: 'te');
    super.initState();

// This will print "initState() ---> MainPage"
  }
  Future<void> signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedin', false);
    // Trigger the authentication flow
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);
        setState(() {
          loginfail = false;
          prefs.setBool('isLoggedin', true);
          print(prefs.getBool('isLoggedin'));
        });
    }
    catch(e){
      print(e);
      setState(() {
        print("!@#**************************************");
        loginfail = true;
        prefs.setBool('isLoggedin', false);
        print(prefs.getBool('isLoggedin'));
      });
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
      // check_if_already_login();
    }
  }

  @override
  Widget build(BuildContext context) {
    final translator = GoogleTranslator();
    return Scaffold(
      appBar: AppBar(
        title:Text("Login To Kisan Sahay"),
      ),
      resizeToAvoidBottomInset: true,

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(

            children: [
              SizedBox(height: 20.0),

              Container(
                height: 300.0,
                child: Image(image: AssetImage("assets/images/login.jpg"),
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
                              labelText: temail,
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
                         // controller: _passwordController,
                          obscureText: _obscureText,
                          decoration:  InputDecoration(
                              labelText: tpass,
                              errorText: loginfail ? terror : null,
                              prefixIcon: Icon(Icons.lock_rounded),
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
                            /*IconButton(
                              icon: Icon(Icons.remove_red_eye_rounded,
                                color: this._obscureText ? Colors.blue : Colors.grey,
                              ),

                              onPressed: () {
                                setState(() => _obscureText= !_obscureText

                                );
                              },
                            )*/

                          ),

                          validator: (val) =>
                          val!.length < 6 || val == null
                              ? 'Password too short.'
                              : null,
                          onChanged: (val) => _password = val,
                          //obscureText: _obscureText,



                        ),
                      ),


                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (BuildContext context)=> new Reset())
                          );
                        },
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),

                      SizedBox(height: 20.0),

                      ElevatedButton(
                          onPressed:() {
                            signIn();
                            },
                          style: ElevatedButton.styleFrom(primary: Colors
                              .green, shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),

                          ),),

                          child: Text(tsubmit, style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),))
                    ],
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}