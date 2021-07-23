import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';


class Donate extends StatefulWidget {
  final String typename;
  const Donate({Key? key,required this.typename}) : super(key: key);

  @override
  _DonateState createState() => _DonateState(typename);
}

class _DonateState extends State<Donate>
{
  String typename ;
  _DonateState(this.typename);
  String _imageurl="";
  late File _imagefile;
  bool done = false;
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String cost = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future pickImage() async {
    await Permission.photos.request();
    var per = await Permission.photos.status;
    if(per.isGranted) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      var file = File(pickedFile!.path);

      // var fileName = basename(pickedFile!.path);

      setState(() {
        // _imageurl =dowurl.toString();
        _imagefile=file;
        done = true;
        // print(_imageurl);
        // _imagefile=file;
      });
    }
    else{
      print('permision denied for photos@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2');
    }
  }

  Future submit(context) async {

    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:ss').format(now);
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("uploads")
          .child("$formattedDate.jpg");
     UploadTask uploadTask = ref.putFile(_imagefile);

      await uploadTask.whenComplete(() async {
        _imageurl = await uploadTask.snapshot.ref.getDownloadURL();
      });
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
         var docsnapshot = await users.doc(_auth.currentUser!.uid).get();
      var df = (docsnapshot.data() as Map<String, dynamic>);
      // print(df['rating']);
      DocumentReference d= await FirebaseFirestore.instance.collection('Equip').doc(typename).collection('items').add(
          {'phn':df['phoneNumber'],'name':df['name'],'adress':df['adress'],'locality':df['locality'],'postal':df['postal'],'cost':cost.toString(),'dowpath':_imageurl,'owner':_auth.currentUser!.uid.toString(),});

      await users.doc(_auth.currentUser!.uid.toString()).collection("uploads").doc(d.id).set(
          {'dowpath':_imageurl,'typename':typename,'name':df['name'],'cost':cost.toString(),'adress':df['adress'],'locality':df['locality'],'postal':df['postal'],'phn':df['phoneNumber']});
      Navigator.pop(context);

    } catch (error) {
      print(error);
      print("111");
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:TitleBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Donate the "+typename+" you have",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                ),
              ),
          SizedBox(height: 10,),
          (done != false)
              ? Image.file(_imagefile,
            width: double.infinity,
          height: 200,
          fit: BoxFit.fill,) : Image.asset('assets/images/upload.png'),
              SizedBox(height: 30.0,),
              ElevatedButton(
                child: Text('choose image'),
                onPressed: pickImage,
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      Container(

                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Cost per day',
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
                          onChanged: (value) => cost = value.toString(),

                        ),
                      ),

                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          ElevatedButton(
                              onPressed:(){
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(primary: Colors
                                  .green, shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),

                              ),),

                              child: Text('Cancel', style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),)),
                          SizedBox(width: 60,),
                          ElevatedButton(
                            onPressed:(){submit(context);},
                            style: ElevatedButton.styleFrom(primary: Colors
                                .green, shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),

                            ),),

                            child: Text('Submit', style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),)),
                    ],
                  ),

          ],
                ),
              ),

    )
            ],

          ),
        ),
      ),
    );
  }


}
