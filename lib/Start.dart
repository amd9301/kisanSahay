import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kisan_sahay/SignUp.dart';
import 'package:kisan_sahay/phoneAuth/EnterNo.dart';

import 'Login.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45.0,),
            Flexible(
              child: Container(
                height: 320.0,
                child: Image(image:AssetImage('assets/images/Start.jfif'),
                fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Container(
              child: RichText(
                  text: TextSpan(
                      text: 'Welcome to',style:TextStyle(fontSize:25.0,fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Kisan Sahay',style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green
                        )
                        )
                      ]
                  )
              ),
            ),
            SizedBox(height: 25.0,),
            Text('A New Way of Sharing instruments',style: TextStyle(
              color:  Colors.black
            ),
            ),
            SizedBox(height: 25.0,),
          Flexible(
            child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 10.0),
                  child: ElevatedButton(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );},
                      style: ElevatedButton.styleFrom(primary: Colors.green,shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),

                      ),),
                      child: Text('LOG IN',style: TextStyle(
                          fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white
                      ),)),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: ElevatedButton(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );},
                      style: ElevatedButton.styleFrom(primary: Colors.green,shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),

                      ),),

                      child: Text('REGISTER',style: TextStyle(
                          fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white
                      ),)),
                )
              ] ,
            ),
          ),
            SizedBox(height: 20.0),
            Text("OR",style:TextStyle(fontSize: 26,fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              icon: const Text('Sign-In With Phone Number'),
              label: Icon(Icons.phone),
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhoneLogin()),
              );},
            )
          ],
        ),
      ),
    );
  }
}
