import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/models/category.dart';
import 'package:kisan_sahay/models/subcategory.dart';
import 'package:kisan_sahay/models/subcategory.dart';
import 'package:kisan_sahay/pages/details.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:translator/translator.dart';
import 'package:kisan_sahay/globals.dart' as globals;
class SelectedCategoryPage extends StatefulWidget {
String typename ;

 // Stream<QuerySnapshot> _equipStream;
SelectedCategoryPage({required this.typename}) {}

  @override
  _SelectedCategoryPageState createState() => _SelectedCategoryPageState(typename);
}

class _SelectedCategoryPageState extends State<SelectedCategoryPage> {
  String typename;
  _SelectedCategoryPageState(this.typename);

  /*void distance()
  {
    double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
    print(distanceInMeters);
  }*/
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _equipStream = FirebaseFirestore.instance.collection('Equip').doc(typename).collection('items').snapshots();
    double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
    print('Distance');
    print(distanceInMeters);
    return Scaffold(

        appBar: TitleBar(),
        body: Column(
          children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            FutureBuilder(
                future: this.typename.translate(to: globals.lang).then((value) =>  value.text),
                initialData:this.typename,
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  return  Text(text.data.toString(),textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.pink,fontSize: 30
                    ),);
                })

          ],
        ),
        SizedBox(height: 10,),
         Expanded(child:
         StreamBuilder<QuerySnapshot>(
              stream: _equipStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    strokeWidth: 6,color: Colors.blue,),);
                }

                return GridView.count(crossAxisCount: 2,
                children: List.generate( snapshot.data!.docs.length,
                (i) {

                    return GestureDetector(
                      onTap:(){
                        // // To do : Navigate to the details page
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(
                                      typename:typename,
                                      loc:snapshot.data!.docs.elementAt(i)['locality'],
                                      phn:snapshot.data!.docs.elementAt(i)['phn'],
                                      name:snapshot.data!.docs.elementAt(i)['name'],
                                      id: snapshot.data!.docs[i].id,
                                      url: snapshot.data!.docs.elementAt(i)['dowpath'],
                                      cost: snapshot.data!.docs.elementAt(i)['cost'].toString(),
                                    )
                            )
                        );
                      } ,
                      child: Container(
                        child: Column(
                          children: [
                           /* ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(snapshot.data!.docs.elementAt(i)['dowpath'],
                                fit: BoxFit.cover,width: 150,height: 120,
                              ),
                            ),*/
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: CachedNetworkImage(
                                height: 120,
                                width: 150,
                                fit: BoxFit.fill,
                                imageUrl:
                                snapshot.data!.docs.elementAt(i)['dowpath'],
                                placeholder: (context, url) => CircularProgressIndicator(
                                  color: Colors.grey,
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                            SizedBox(height: 10,),
                            FutureBuilder(
                                future:  snapshot.data!.docs.elementAt(i)['locality'].toString().translate(to: globals.lang).then((value) =>  value.text),
                                initialData:snapshot.data!.docs.elementAt(i)['locality'].toString(),
                                builder: (BuildContext context, AsyncSnapshot<String> text) {
                                  // print(text);
                                  return  Text(text.data.toString(),style : TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold
                                  ),);
                                }),
                            Text("₹"+snapshot.data!.docs.elementAt(i)['cost'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),)
                          ],
                        ),
                      ),
                    );
                  },)


            );
    }))
        ]
        )
    );
  }
}