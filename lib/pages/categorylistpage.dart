import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'package:kisan_sahay/pages/selectedcategorypage.dart';
import 'package:kisan_sahay/pages/yourUploads.dart';
import 'package:kisan_sahay/widgets/categorycard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Start.dart';
import 'Personal.dart';
import 'Predonate.dart';
import 'cart.dart';
import 'package:translator/translator.dart';
import 'package:kisan_sahay/globals.dart' as globals;
class CategoryListPage extends StatefulWidget {


  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final Stream<QuerySnapshot> _equipStream = FirebaseFirestore.instance.collection('Equip').snapshots();
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
                onTap: () {
                  _signOut();
                },
              ),
            ],
          ),

        ),
        appBar: AppBar(
          title: Text('Kisan Sahay',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green[600],
              fontSize: 24.0,
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
                      child:FutureBuilder(
                          future:  "Select a Category".translate(to: globals.lang).then((value) =>  value.text),
                          initialData:"Select a Category",
                          builder: (BuildContext context, AsyncSnapshot<String> text) {
                            return  Text(text.data.toString(),textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                ));
                          })

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
