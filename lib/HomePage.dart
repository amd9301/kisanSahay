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

import 'Need.dart';
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
                title: new Text('Nearby Users'),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new NearbyMap())
                  );
                },
              ),
              new ListTile(
                title: new Text('Donate Machinery'),
                onTap: () {
                  Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context)=> new Disp())
                  );
                },
              ),
              new ListTile(
                title: new Text('Need Machinery'),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new CategoryListPage())
                  );
                },
              ),
              new ListTile(
                title: new Text('Cart'),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new Cart())
                  );
                },
              ),
              new ListTile(
                title: new Text('Your Orders'),
                onTap: () {},
              ),
              new ListTile(
                title: new Text('Your Uploads'),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new YourUploads())
                  );
                },
              ),
              new ListTile(
                title: new Text('Sign Out'),
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
                    Text(
                      "Select your action",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      ),
                    ),

                    SizedBox(height: 20),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber, // background
                            onPrimary: Colors.white, // foreground
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),

                          ),
                          child: Text(
                            " Need Machinery  ", style: TextStyle(fontSize: 20),),
                          onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CategoryListPage()),
                          );},

                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            primary: Colors.amber, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          child: Text("Donate Machinery", style: TextStyle(fontSize: 20),),
                          onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Disp()),
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
