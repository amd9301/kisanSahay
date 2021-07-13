import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:kisan_sahay/pages/cart.dart';
import 'package:kisan_sahay/pages/Payment.dart';
import 'package:kisan_sahay/models/subcategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Changeupload extends StatefulWidget {
  final   String id ;
  final   String url ;
  final String typename ;
  final String cost ;
  const Changeupload({Key? key,required this.typename,required this.id,required this.url,required this.cost}) : super(key: key);

  @override
  _ChangeuploadState createState() => _ChangeuploadState(id,typename,url,cost);
}

class _ChangeuploadState extends State<Changeupload> {

  String id ;
  String url ;
  String cost ;
  String typename ;
  _ChangeuploadState(this.id,this.typename,this.url,this.cost);

  Future changecost() async{
    await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("uploads").doc(id).update({
      'cost':cost,
    });
    Navigator.pop(context,);
  }
  Future del() async{
    await FirebaseFirestore.instance.collection("Equip").doc(typename).collection('items').doc(id).delete();
    await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("uploads").doc(id).delete();
    FirebaseStorage.instance.refFromURL(url).delete();
    Navigator.pop(context,);
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TitleBar(),
      body:Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        )
                    ),
                  ) ,
                  Positioned.fill(
                      child:
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin:     Alignment.bottomCenter,
                                end: Alignment.topCenter
                                , colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent
                            ])
                        ),

                      )
                  ) ,
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right:0 ,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:
                          [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Text(typename,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  )
                                  ,) ,
                                SizedBox(height: 10,),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration:
                                    BoxDecoration
                                      (
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child:Text(cost+' per day',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),)

                                )
                              ],
                            )

                          ],

                        ),
                      ))

                ],

              ),
            ),


            SizedBox(height: 20,),
            Expanded(
                child:
                SingleChildScrollView(
                  child: Container(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15,right:10),
                            child: Container(

                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Change Cost per day',
                                    prefixIcon: Icon(Icons.money)
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters:[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Please enter cost per day';
                                  }

                                  // Return null if the entered email is valid
                                  return null;
                                },
                                onChanged: (value) => cost =value.toString(),

                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Text('Other Details',
                               style: TextStyle(
                                   fontSize: 20,
                                 fontWeight: FontWeight.bold
                               ),
                             ),
                             SizedBox(height: 20),
                             Padding(
                               padding: EdgeInsets.fromLTRB(20, 0,0,20),
                               child: Row(
                                 children: [
                                   Text(
                                     'Location',style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 20,
                                   ),),
                                   SizedBox(width: 50,),
                                   Text('Village Name',
                                     textAlign: TextAlign.right,
                                     style: TextStyle(
                                       color: Colors.black,
                                       fontSize: 20,
                                     ),),

                                 ],
                               ),

                             ),
                            /* ElevatedButton(
                                 onPressed: (){},
                                 //onPressed: del,
                                 style: ElevatedButton.styleFrom(
                                   primary: Colors.lightBlueAccent,
                                   shape: new RoundedRectangleBorder(
                                     borderRadius: new BorderRadius.circular(20.0),

                                   ),),*/
                                  //child:
                                Center(
                                     child: ElevatedButton.icon(
                                       icon: Icon(
                                         Icons.location_on_sharp,
                                         color: Colors.white,
                                         size: 24.0,
                                       ),
                                       label: Text('Change Location'),
                                       onPressed: () {
                                        // print('Change Location Button Pressed');
                                       },
                                       style: ElevatedButton.styleFrom(
                                         shape: new RoundedRectangleBorder(
                                           borderRadius: new BorderRadius.circular(30.0),
                                         ),
                                       ),
                                     )
                                 )
                             //),
                           ],

                         ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: del,
                                    style: ElevatedButton.styleFrom(primary: Colors
                                        .green, shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(20.0),

                                    ),),

                                    child: Text('Delete ', style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),)
                                ),
                                //SizedBox(width: 70,),
                                ElevatedButton(
                                    onPressed:changecost,
                                    style: ElevatedButton.styleFrom(primary: Colors
                                        .green, shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(20.0),

                                    ),),

                                    child: Text('Change', style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),))
                              ],
                            ),
                          )

                        ],
                      )

                  ),
                ))
          ],
        ),
      ),
    );
  }
}
