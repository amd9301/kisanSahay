import 'package:flutter/material.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'package:kisan_sahay/pages/categorylistpage.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';

import 'Predonate.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(),
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
              title: new Text('Home'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context)=> new HomePage())
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
      body: Center(
        child: Container(
          child: Text('Cart Page'),
        ),
      ),
    );
  }
}
