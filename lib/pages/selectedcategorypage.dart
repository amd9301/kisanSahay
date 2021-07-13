import 'package:flutter/material.dart';
import 'package:kisan_sahay/models/category.dart';
import 'package:kisan_sahay/models/subcategory.dart';
import 'package:kisan_sahay/models/subcategory.dart';
import 'package:kisan_sahay/pages/details.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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



  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _equipStream = FirebaseFirestore.instance.collection('Equip').doc(typename).collection('items').snapshots();

    return Scaffold(
  
        appBar: TitleBar(),
        body: Column(
          children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Text(this.typename,
              style: TextStyle(
                  color: Colors.pink,fontSize: 30
              ),)
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(snapshot.data!.docs.elementAt(i)['dowpath'],
                                fit: BoxFit.cover,width: 150,height: 120,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(typename,
                              style: TextStyle(
                                  color: Colors.red,
                                fontWeight: FontWeight.bold

                              ),),
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