import 'package:flutter/material.dart';
import 'package:kisan_sahay/SignUp.dart';
import 'package:kisan_sahay/Start.dart';
import 'package:kisan_sahay/pages/cart.dart';
import 'package:kisan_sahay/pages/categorylistpage.dart';
import 'package:kisan_sahay/pages/Donate.dart';
import 'package:kisan_sahay/pages/Personal.dart';
import 'package:kisan_sahay/pages/Predonate.dart';
import 'package:kisan_sahay/Login.dart';
import 'package:kisan_sahay/pages/map.dart';
import 'package:kisan_sahay/widgets/categorybottombar.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:kisan_sahay/globals.dart' as globals;

import 'pages/yourUploads.dart';
class HomePage extends StatefulWidget {
  // final String url;
  const HomePage({Key? key,}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user =FirebaseAuth.instance.currentUser;
  /*Future<void> _signOut() async {
    //await FirebaseAuth.instance.signOut();
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context)=> new Cart())
    );

  }*/

  // final prefs = await SharedPreferences.getInstance();


  bool signedout=false;
  FirebaseAuth _auth=FirebaseAuth.instance;
  Future<Null> _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedin', false);
    await _auth.signOut();
    this.setState(() {
      signedout = true;
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Start()),
            (Route<dynamic> route) => false);
  }
  @override
  Widget build(BuildContext context) {

    user!.reload();
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            children: [
               UserAccountsDrawerHeader(accountName: new Text(user!.displayName.toString()),
                accountEmail: new Text(user!.email.toString()),
                currentAccountPicture:         GestureDetector(
                  onTap: () async {
                    await Navigator.push(context,
                        new MaterialPageRoute(builder: (BuildContext context)=> new PersonalPage(
                          url:user!.photoURL.toString(),
                        ))
                    );
                    setState(() {
                      user=FirebaseAuth.instance.currentUser;
                      print("!!!");
                    });
                  },

                  child: CircleAvatar(
                    radius: 35,
                  foregroundImage:  NetworkImage(user!.photoURL.toString()),
                    backgroundImage: AssetImage('assets/images/load1.png'),

                ),
                )
              ),
              new ListTile(
                title:  (globals.lang=="en") ? Text("Nearby Users") : FutureBuilder(
                      future:  "nearby users".translate(to: globals.lang).then((value) =>  value.text),
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  if(text.hasData){
                    return  Text(text.data.toString());}
                  return Text("Nearby Users");
                }),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new NearbyMap())
                  );
                },
              ),
              new ListTile(
                title: (globals.lang=="en") ? Text("Donate Machinery") : FutureBuilder(
                    future:  "Donate Machinery".translate(to: globals.lang).then((value) =>  value.text),
                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                      if(text.hasData){
                        return  Text(text.data.toString());}
                      return Text("Nearby Users");
                    }),
                onTap: () {
                  Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context)=> new Disp())
                  );
                },
              ),
              new ListTile(
                title:  (globals.lang=="en") ? Text("Need Machinery") : FutureBuilder(
                    future:  "Needed machinery".translate(to: globals.lang).then((value) =>  value.text),
                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                      if(text.hasData){
                        return  Text(text.data.toString());}
                      return Text("Need Machinery");
                    }),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new CategoryListPage())
                  );
                },
              ),
              new ListTile(
                title:  (globals.lang=="en") ? Text("Cart") : FutureBuilder(
                  future:  "Cart".translate(to: globals.lang).then((value) =>  value.text),
                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                  if(text.hasData){
                  return  Text(text.data.toString());}
                  return Text("Cart");
              }),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new Cart())
                  );
                },
              ),
              new ListTile(
                title:  (globals.lang=="en") ? Text("Your Oders") : FutureBuilder(
                    future:  "Your Oders".translate(to: globals.lang).then((value) =>  value.text),
                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                      if(text.hasData){
                        return  Text(text.data.toString());}
                      return Text("Your Oders");
                    }),
                onTap: () {},
              ),
              new ListTile(
                title:  (globals.lang=="en") ? Text("Your Uploads") : FutureBuilder(
                    future:  "Your Uploads".translate(to: globals.lang).then((value) =>  value.text),
                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                      if(text.hasData){
                        return  Text(text.data.toString());}
                      return Text("Your Uploads");
                    }),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new YourUploads())
                  );
                },
              ),
              new ListTile(
                title: (globals.lang=="en") ? Text("Sign Out") : FutureBuilder(
                    future:  "Sign Out".translate(to: globals.lang).then((value) =>  value.text),
                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                      if(text.hasData){
                        return  Text(text.data.toString());}
                      return Text("Sign Out");
                    }),
                onTap: () {
                  //_signOut();
                  _signOut();
                },
              ),
            ],
          ),
        ),

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
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(10),
              child: ClipOval(
                child: IconButton
                  (
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (BuildContext context)=> new Cart())
                      );
                    },),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.fromLTRB(0,0,0,0),
              child: ClipOval(
                  child: IconButton(
                    icon: Icon(Icons.translate, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        if(globals.lang=="te")globals.lang="en";
                        else globals.lang="te";
                        print(globals.lang);
                        // changelang();
                      });
                    },
                  ),
              ),
            )
          ],
        ),
        body:  Container(
            child:
              Stack(
                children:[
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                  /*  Text(
                      "Hello! Welcome  ",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    */
                    SizedBox(height: 20.0),
                    Center(
                      child: Image(
                        image: AssetImage('assets/images/welcome.jpg'),
                      ),
                    ),
                    SizedBox(height: 20.0),
                     FutureBuilder(
                        future:  "Choose Your action".translate(to: globals.lang).then((value) =>  value.text),
                        initialData: "Choose your Action",
                        builder: (BuildContext context, AsyncSnapshot<String> text) {
                            return  Text(text.data.toString(),style: TextStyle(
                              color: Colors.pink,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,

                            ),);
                        }),

                                       SizedBox(height: 20),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: Colors.amber ,
                          textColor: Colors.white,
                          minWidth: 250,
                          hoverElevation: 10,
                          //
                          child:
                          FutureBuilder(
                              future:  "Donate Machinery".translate(to: globals.lang).then((value) =>  value.text),
                              initialData: "Donate Machinery",
                              builder: (BuildContext context, AsyncSnapshot<String> text) {
                                return  Text(text.data.toString(),style:TextStyle(fontSize: 20));
                              }),
                          onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Disp()),
                          );},

                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: Colors.amber ,
                          minWidth: 250,
                          textColor: Colors.white,
                        hoverElevation: 10,
                        //
                          child: FutureBuilder(
                              future:  "Needed Machinery".translate(to: globals.lang).then((value) =>  value.text),
                              initialData: "Need Machinery",
                              builder: (BuildContext context, AsyncSnapshot<String> text) {
                                return  Text(text.data.toString(),style:TextStyle(fontSize: 20));
                              }),
                          onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CategoryListPage()),
                          );},

                        ),

                      ],
                    )

                  ],
                ),

             ]
              ),
          //Add bottom nav bar her
          //...

          ),



      ),
    );
  }
}
