import 'package:translator/translator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/SignUp.dart';
import 'package:kisan_sahay/phoneAuth/EnterNo.dart';
import 'package:kisan_sahay/globals.dart' as globals;
import 'Login.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  final translator = GoogleTranslator();



  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //resizeToAvoidRightInset:true,
      body: Container(

        child: Center(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
//              SizedBox(height: 25.0,),
            Flexible(
              child: Column(
              //crossAxisAlignment: CrossAxisAlignment.,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: ElevatedButton(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );},
                      style: ElevatedButton.styleFrom(primary: Colors.green,shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),

                      ),),
                      child: FutureBuilder(
                          future:  "Sign In".translate(to: globals.lang).then((value) =>  value.text),
                          initialData: "Login",
                          builder: (BuildContext context, AsyncSnapshot<String> text) {
                            return  Text(text.data.toString(),style:TextStyle(
                                fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white
                            ),);
                          }),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10.0,right: 10.0),
                  child: ElevatedButton(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );},
                      style: ElevatedButton.styleFrom(primary: Colors.green,shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),

                      ),),

                      child: FutureBuilder(
                          future:  "Register".translate(to: globals.lang).then((value) =>  value.text),
                          initialData: "Sign up",
                          builder: (BuildContext context, AsyncSnapshot<String> text) {
                            return  Text(text.data.toString(),style:TextStyle(
                                fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white
                            ),);
                          }),
                  ),
                )
              ] ,
                ),
            ),
              Text("OR",style:TextStyle(fontSize: 26,fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                icon: FutureBuilder(
                    future:  "Sign-In With Phone Number".translate(to: globals.lang).then((value) =>  value.text),
                    initialData: "Sign-In With Phone Number",
                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                      return  Text(text.data.toString());
                    }),
                label: Icon(Icons.phone),
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneLogin()),
                );},
              )
            ],
          ),
        ),
      ),
    );
  }
}
