import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'package:kisan_sahay/helpers/utils.dart';
import 'package:kisan_sahay/models/category.dart';
import 'package:kisan_sahay/pages/selectedcategorypage.dart';
import 'package:kisan_sahay/pages/Donate.dart';
import 'package:kisan_sahay/pages/yourUploads.dart';
import 'package:kisan_sahay/widgets/categorybottombar.dart';
import 'package:kisan_sahay/widgets/categorycard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Personal.dart';
import 'Predonate.dart';
import 'cart.dart';

class CategoryListPage extends StatelessWidget {


  final Stream<QuerySnapshot> _equipStream = FirebaseFirestore.instance.collection('Equip').snapshots();

  @override
  Widget build(BuildContext context) {

    User? user =FirebaseAuth.instance.currentUser;
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              new UserAccountsDrawerHeader(accountName: new Text(user!.displayName.toString()),
                  accountEmail: new Text(user.email.toString()),
                  currentAccountPicture:         GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (BuildContext context)=> new PersonalPage(
                            url:user.photoURL.toString(),
                          ))
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage:  NetworkImage(FirebaseAuth.instance.currentUser!.photoURL.toString()),
                    ),)
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
                title: new Text('Cart'),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new Cart())
                  );
                },
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
                onTap: () {},
              ),
            ],
          ),

        ),
        appBar: AppBar(
          title: Text('Kisan Sahay',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green[600],
              fontSize: 30.0,
            ),),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color:Colors.green[800], ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(10),
              child: ClipOval(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.green[600]),
                  onPressed: () {Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new Cart())
                  );},
                ),
              ),
            )
          ],
        ),
        body: Container(
          child: Stack(
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                      child: Text('Select a category',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),),
                    ),

                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: _equipStream,
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator(strokeWidth: 5,color: Colors.red,),);
                              }
                              return ListView.builder(itemCount : snapshot.data!.docs.length,
                                  padding: EdgeInsets.only(bottom: 60),
                                  itemBuilder: (BuildContext ctx,i){
                                    return
                                      CategoryCard(
                                        url:snapshot.data!.docs.elementAt(i)['dowurl'],
                                        name: snapshot.data!.docs[i].id,
                                        onCardClick:(){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>
                                                  SelectedCategoryPage(
                                                   typename: snapshot.data!.docs[i].id.toString(),)));
                                        },

                                      );
                                  }
                              );
                            }
                        )
                    )

                  ],
                ),
              ]
          ),
        )
    );
  }
}
