import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:kisan_sahay/pages/Predonate.dart';
import 'package:kisan_sahay/pages/cart.dart';
import 'package:kisan_sahay/pages/categorylistpage.dart';
import 'package:kisan_sahay/pages/selectedcategorypage.dart';
import 'package:kisan_sahay/pages/yourUploads.dart';

import 'categorycard.dart';

class NewDrawer extends StatefulWidget {
  const NewDrawer({Key? key}) : super(key: key);

  @override
  _NewDrawerState createState() => _NewDrawerState();
}

class _NewDrawerState extends State<NewDrawer>
{
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  //final _advancedDrawerController = AdvancedDrawerController();
  Widget build(BuildContext context) {
    return Container(
        child:Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _userStream,
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
                         /* CategoryCard(
                            url:snapshot.data!.docs.elementAt(i)['dowurl'],
                            name: snapshot.data!.docs[i].id,
                            onCardClick:(){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>
                                      SelectedCategoryPage(
                                        typename: snapshot.data!.docs[i].id.toString(),)));
                            },

                          );*/
                        Container(
                          child: Text(snapshot.data!.docs.elementAt(i)['latitude'].toString()),
                        );
                      }
                  );
                }
            )
        )
    );
  }
}
