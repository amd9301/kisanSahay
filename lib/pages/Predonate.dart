import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kisan_sahay/pages/Donate.dart';
class Disp extends StatefulWidget {
  const Disp({Key? key}) : super(key: key);

  @override
  _DispState createState() => _DispState();
}

class _DispState extends State<Disp> {

  final Stream<QuerySnapshot> _equipStream = FirebaseFirestore.instance.collection('Equip').snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
              child: Icon(Icons.supervised_user_circle_rounded),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
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
            itemBuilder: (context,i){
              return(
              Card(color: Colors.blue,
              child: ElevatedButton(
                child: Text(snapshot.data!.docs[i].id),
                onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Donate(typename: snapshot.data!.docs[i].id)),
                );},
              ),
              elevation: 1.0,
                
              )
              );
            },);
          },
        ),
      ),
    );
  }
}


