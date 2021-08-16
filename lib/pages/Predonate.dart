import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisan_sahay/pages/Donate.dart';
import 'package:kisan_sahay/widgets/categorybottombar.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';

import 'package:translator/translator.dart';
import 'package:kisan_sahay/globals.dart' as globals;
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

      appBar: TitleBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child:Column(
        children:[
          FutureBuilder(
              future:  "Select".translate(to: globals.lang).then((value) =>  value.text),
              builder: (BuildContext context, AsyncSnapshot<String> text) {

                if(text.hasData){ return  Text(text.data.toString(),style: TextStyle(
                  color: Colors.orange[800],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,

                ),);}

                return Text(
                  "Select the Category",
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,

                  ),
                );
              }),


          SizedBox(height: 20),
         Expanded(child:
         StreamBuilder<QuerySnapshot>(
                  stream: _equipStream,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(
                        // backgroundColor: Colors.grey,
                        strokeWidth: 6,color: Colors.blue,),);
                    }

                    return ListView.builder(itemCount : snapshot.data!.docs.length,
                    itemBuilder: (context,i){
                      return(
                      Card(
                        color: Colors.green[200],
                        margin: EdgeInsets.fromLTRB(50,10,50,11),
                       child: Padding(
                        padding: EdgeInsets.all(6),
                        child: ElevatedButton(
                          child: FutureBuilder(
                              future:  snapshot.data!.docs[i].id.translate(to: globals.lang).then((value) =>  value.text),
                              builder: (BuildContext context, AsyncSnapshot<String> text) {
                               if(text.hasData){
                                 return  Text(text.data.toString());}
                               return Text(snapshot.data!.docs[i].id);
                              }),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),

                          ),),
                          onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Donate(typename: snapshot.data!.docs[i].id)),
                          );},

                        ),
                      ),
                      elevation: 1.0,

                      )
                      );
                    },);
                  },
                ),
         )
        ]
        )


              ),

      );

  }
}


