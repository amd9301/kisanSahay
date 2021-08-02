import 'package:flutter/material.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'package:kisan_sahay/pages/categorylistpage.dart';
import 'package:kisan_sahay/pages/showcart.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:kisan_sahay/widgets/categorycard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Predonate.dart';
import 'package:translator/translator.dart';
import 'package:kisan_sahay/globals.dart' as globals;
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
                backgroundImage: new NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_mCyTdVerlZkBa4mPc5wDWUXmbGcIuxaN-1FJ1kJ8BS6rq7vrD1B4Rm33wgyRRTFccwQ&usqp=CAU'
                ),
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
        body :Container(
          child: Stack(
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                      child:FutureBuilder(
                          future: 'Your cart'.translate(to: globals.lang).then((value) =>  value.text),
                          initialData:'Your cart',
                          builder: (BuildContext context, AsyncSnapshot<String> text) {
                            return  Text(text.data.toString(), textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),);
                          }),
                    ),

                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator(strokeWidth: 5,color: Colors.pink,),);
                              }
                              if(snapshot.data!.docs.length==0)
                              {
                                 return Container(
                                   child:
                                     Column(
                                       children: [
                                         SizedBox(height: 50,),
                                         Image.asset('assets/images/emptyCart.png',colorBlendMode: BlendMode.lighten),
                                         Text('Your Cart is Empty',style: TextStyle(
                                             fontSize: 30,fontWeight: FontWeight.bold
                                         ),),

                                       ],
                                     )
                                 );
                              }

                              return ListView.builder(itemCount : snapshot.data!.docs.length,
                                   //(itemCount==0?  return Text("Cart is Empty"))

                              padding: EdgeInsets.only(bottom: 60),
                                  itemBuilder: (BuildContext ctx,i){

                                    return
                                      CategoryCard(
                                        url:snapshot.data!.docs.elementAt(i)['dowpath'],
                                        name: snapshot.data!.docs.elementAt(i)['typename'],
                                        onCardClick:(){
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Showcart(
                                                        typename:snapshot.data!.docs.elementAt(i)['typename'],
                                                        name:snapshot.data!.docs.elementAt(i)['name'],
                                                        phn:snapshot.data!.docs.elementAt(i)['phn'],
                                                        loc:snapshot.data!.docs.elementAt(i)['locality'],
                                                        id: snapshot.data!.docs[i].id,
                                                        url: snapshot.data!.docs.elementAt(i)['dowpath'],
                                                        cost: snapshot.data!.docs.elementAt(i)['cost'].toString(),
                                                      )
                                              )
                                          );
                                        },

                                      );
                                  }
                              );
                            }
                        )
                    )

                  ],
                ),
               /* Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child:
                  CategoryBottomBar(),
                )*/
              ]
          ),
        )
    );
  }
}
