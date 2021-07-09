import 'package:flutter/material.dart';
import 'package:kisan_sahay/pages/categorylistpage.dart';
import 'package:kisan_sahay/pages/Donate.dart';
import 'package:kisan_sahay/pages/Predonate.dart';
import 'package:kisan_sahay/widgets/categorybottombar.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';

import 'Need.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer() ,
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
                child: Icon(Icons.supervised_user_circle_rounded),
              ),
            )
          ],
        ),
        body:  Container(
            child:
              Stack(
                children:[ Column(
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
                    Center(
                      child: Image(
                        image: AssetImage('assets/images/start.jpg'),
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
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child:
                    CategoryBottomBar(),
                  )
             ]
              ),



          ),



      ),
    );
  }
}
