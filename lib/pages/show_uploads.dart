import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'package:kisan_sahay/pages/showcart.dart';
import 'package:kisan_sahay/pages/Changeupload.dart';
import 'package:kisan_sahay/widgets/categorycard.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:kisan_sahay/pages/details.dart';

import 'Personal.dart';
import 'Predonate.dart';
import 'cart.dart';
import 'categorylistpage.dart';


class ShowUploads extends StatefulWidget {

  final String uid;
  final String name;
  ShowUploads({required this.uid,required this.name}) {}

  @override
  _ShowUploadsState createState() => _ShowUploadsState(uid,name);
}

class _ShowUploadsState extends State<ShowUploads> {
  String uid;
  String name;
  _ShowUploadsState(this.uid,this.name);
  @override
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
                      child: Text(name+' Uploads',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),),
                    ),

                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('Users').doc(uid).collection('uploads').snapshots(),
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
                                        url:snapshot.data!.docs.elementAt(i)['dowpath'],
                                        name: snapshot.data!.docs.elementAt(i)['typename'],
                                        onCardClick:() async {
                                          await  Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(
                                                        typename:snapshot.data!.docs.elementAt(i)['typename'],
                                                        loc:snapshot.data!.docs.elementAt(i)['locality'],
                                                        phn:snapshot.data!.docs.elementAt(i)['phn'],
                                                        name:snapshot.data!.docs.elementAt(i)['name'],
                                                        id: snapshot.data!.docs[i].id,
                                                        url: snapshot.data!.docs.elementAt(i)['dowpath'],
                                                        cost: snapshot.data!.docs.elementAt(i)['cost'].toString(),
                                                      )
                                              )
                                          );
                                          setState(() {

                                          });
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
