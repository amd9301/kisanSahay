import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'package:kisan_sahay/pages/showcart.dart';
import 'package:kisan_sahay/widgets/categorycard.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';

import 'Personal.dart';
import 'Predonate.dart';
import 'cart.dart';
import 'categorylistpage.dart';


class YourUploads extends StatefulWidget {


  @override
  _YourUploadsState createState() => _YourUploadsState();
}

class _YourUploadsState extends State<YourUploads> {
  @override
  User? user =FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TitleBar(),
      body: Container(
        child: Stack(
            children:[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                    child: Text('Your Uploads',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),),
                  ),

                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('uploads').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(strokeWidth: 5,color: Colors.pink,),);
                            }
                            /*if(snapshot.data!.docs.length==0)
                            {
                              return Container(
                                  child:
                                  Column(
                                    children: [
                                      SizedBox(height: 50,),
                                      Image.asset('assets/images/emptyCart.png',colorBlendMode: BlendMode.lighten),
                                      Text("You have no uploads",style: TextStyle(
                                          fontSize: 30,fontWeight: FontWeight.bold
                                      ),),

                                    ],
                                  )
                              );
                            }
*/
                            return ListView.builder(itemCount : snapshot.data!.docs.length,
                                //(itemCount==0?  return Text("Cart is Empty"))

                                padding: EdgeInsets.only(bottom: 60),
                                itemBuilder: (BuildContext ctx,i){

                                  return
                                    CategoryCard(
                                        url:snapshot.data!.docs.elementAt(i)['dowurl'],
                                      name: snapshot.data!.docs.elementAt(i)['typename'],
                                      onCardClick:(){
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Showcart(
                                                      typename:snapshot.data!.docs.elementAt(i)['typename'],
                                                      id: snapshot.data!.docs[i].id,
                                                      url: snapshot.data!.docs.elementAt(i)['dowurl'],
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
