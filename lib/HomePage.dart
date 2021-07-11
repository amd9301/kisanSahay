import 'package:flutter/material.dart';
import 'package:kisan_sahay/pages/cart.dart';
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
        drawer: Drawer(
          child: ListView(
            children: [
              new UserAccountsDrawerHeader(accountName: new Text('User Name'),
                accountEmail: new Text('test@gmail.com'),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_mCyTdVerlZkBa4mPc5wDWUXmbGcIuxaN-1FJ1kJ8BS6rq7vrD1B4Rm33wgyRRTFccwQ&usqp=CAU'),
                ),
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
                title: new Text('Settings'),
                onTap: () {},
              ),
              new ListTile(
                title: new Text('Sign Out'),
                onTap: () {},
              ),
            ],
          ),

        ),

        appBar:  AppBar(
          title: Text('   Kisan Sahay',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green[600],
              fontSize: 30.0,
            ),),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color:Colors.green[800], ),
          elevation: 0.0,

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
                children:[ Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 40.0),
                    Center(
                      child: Image(
                        image: AssetImage('assets/images/welcome.jpg'),
                      ),
                    ),
                    //Divider(height: 6,),
                    SizedBox(height: 30.0),
                    Text(
                      "Select your action",
                      style: TextStyle(
                        color: Colors.pink[300],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,

                      ),
                    ),

                    SizedBox(height: 30),

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
                        SizedBox(height: 15),
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
