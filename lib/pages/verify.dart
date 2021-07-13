import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisan_sahay/pages/Donate.dart';
import 'package:kisan_sahay/widgets/categorybottombar.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

final auth=FirebaseAuth.instance.currentUser;


@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.white,


      appBar:  AppBar(
        title: Text('Kisan Sahay',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 1.0,
        iconTheme: IconThemeData(color:Colors.white, ),

      ),
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 5.0, 10),
        child: Container(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Text(
                    "Hello! Welcome  ",
                    style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 30,
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  SizedBox(height: 20.0),
                   Text("An email has been sent to your mail for verification, Please check your inbox",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,


                      ),
                  ),
                  SizedBox(height: 20.0),

                  ElevatedButton(
                      onPressed:(){
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors
                          .pink, shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),

                      ),),

                      child: Text('Login again', style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),))



                ],
              ),


          ),
      ),
        //Add bottom nav bar her
        //...





    ),
  );




  }
}


