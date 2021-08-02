import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart'as UrlLauncher;
import 'package:translator/translator.dart';
import 'package:kisan_sahay/globals.dart' as globals;
class Showcart extends StatefulWidget {
  final   String id ;
  final   String url ;
  final String typename ;
  final String cost ;
  final String loc ;
  final String phn ;
  final String name ;
  const Showcart(
      {Key? key,required this.typename,required this.name,required this.id,required this.url,required this.phn,required this.loc,required this.cost}
      ) : super(key: key);

  @override
  _ShowcartState createState() => _ShowcartState(id,typename,url,cost,loc,phn,name);
}

class _ShowcartState extends State<Showcart> {

  String id ;
  String url ;
  String cost ;
  String name ;
  String typename ;
  String loc ;
  String phn ;
  _ShowcartState(this.id,this.typename,this.url,this.cost,this.loc,this.phn,this.name);

  Future remove() async{
    await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("cart").doc(id).delete();
    Navigator.pop(context);
  }
  Widget build(BuildContext context) {

    // String url= await ;

    return Scaffold(
      appBar: TitleBar(),
      body:Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                        url,
                        placeholder: (context, url) => CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
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
                                    child:Text("₹ "+cost+' per day',
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
                Container(
                    child:SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder(
                              future: 'Details of the Owner:'.translate(to: globals.lang).then((value) =>  value.text),
                              initialData:'Details of the Owner:',
                              builder: (BuildContext context, AsyncSnapshot<String> text) {
                                return  Text(text.data.toString(),style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),);
                              }),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0,0,0),
                            child: Row(
                              children: [
                                FutureBuilder(
                                    future: 'Name'.translate(to: globals.lang).then((value) =>  value.text),
                                    initialData:'Name',
                                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                                      return  Text(text.data.toString(),style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),);
                                    }),
                                SizedBox(width: 30,),
                                FutureBuilder(
                                    future: name.translate(to: globals.lang).then((value) =>  value.text),
                                    initialData:name,
                                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                                      return  Text(text.data.toString(),style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),);
                                    }),

                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0,0,0),
                            child: Row(
                              children: [
                                FutureBuilder(
                                    future: 'Location'.translate(to: globals.lang).then((value) =>  value.text),
                                    initialData:'Location',
                                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                                      return  Text(text.data.toString(),style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),);
                                    }),

                                SizedBox(width: 30,),
                                FutureBuilder(
                                    future: loc.translate(to: globals.lang).then((value) =>  value.text),
                                    initialData:loc,
                                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                                      return  Text(text.data.toString(),style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),);
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0,0,0),
                            child: Row(
                              children: [
                                FutureBuilder(
                                    future: 'Contact Details'.translate(to: globals.lang).then((value) =>  value.text),
                                    initialData:'Contact Details',
                                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                                      return  Text(text.data.toString(),style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),);
                                    }),
                                SizedBox(width: 30,),
                                FutureBuilder(
                                    future: phn.toString().translate(to: globals.lang).then((value) =>  value.text),
                                    initialData:phn.toString(),
                                    builder: (BuildContext context, AsyncSnapshot<String> text) {
                                      return  Text(text.data.toString(),style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                               child: ElevatedButton(
                                    onPressed:(){
                                      UrlLauncher.launch("tel:"+phn);
                                      /* Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PayPage()
                                        )
                                    );*/
                                    },
                                    style: ElevatedButton.styleFrom(primary: Colors
                                        .green, shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(20.0),

                                    ),),

                                    child: FutureBuilder(
                                        future: 'Rent Now'.translate(to: globals.lang).then((value) =>  value.text),
                                        initialData:'Rent Now',
                                        builder: (BuildContext context, AsyncSnapshot<String> text) {
                                          return  Text(text.data.toString(), style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                          ));
                                        }),
                                ),),
                                SizedBox(height: 10,),
                                ElevatedButton(
                                    onPressed:remove,
                                    style: ElevatedButton.styleFrom(primary: Colors
                                        .green, shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(20.0),

                                    ),),

                                    child: FutureBuilder(
                                  future: 'Remove'.translate(to: globals.lang).then((value) =>  value.text),
                                  initialData:'Remove',
                                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                                  return  Text(text.data.toString(), style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                  ));
                                  }),)



                        ],
                      ),
                    )

                ))
          ],
        ),
      ),
    );
  }
}
