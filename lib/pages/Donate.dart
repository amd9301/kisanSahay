import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';


class Donate extends StatefulWidget {
  final String typename;
  const Donate({Key? key,required this.typename}) : super(key: key);

  @override
  _DonateState createState() => _DonateState(typename);
}

class _DonateState extends State<Donate> {
  String typename ;
  _DonateState(this.typename);
  String _imageurl="";
  late File _imagefile;
  bool done = false;
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int cost = 0;
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
      print('permisin denied for photos@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2');
    }
  }

  Future submit(context) async {

    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);


      Reference ref = FirebaseStorage.instance
          .ref()
          .child("uploads")
          .child("$formattedDate.jpg");
     UploadTask uploadTask = ref.putFile(_imagefile);

      await uploadTask.whenComplete(() async {
        _imageurl = await uploadTask.snapshot.ref.getDownloadURL();
      });
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      await FirebaseFirestore.instance.collection('Equip').doc(typename).collection('items').add(
          {'cost':cost,'dowpath':_imageurl,'owner':_auth.currentUser!.uid.toString()});

      await users.doc(_auth.currentUser!.uid.toString()).collection("uploads").doc(typename).collection("items").add(
          {'imageurl':_imageurl});
      Navigator.pop(context);

    } catch (error) {
      print(error);
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kisan Sahay'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              "Donate the equipment you HAve",
              style: TextStyle(
                color: Colors.pink,
                fontSize: 20,
                fontWeight: FontWeight.bold,

              ),
            ),
        (done != false)
            ? Image.file(_imagefile,
          width: double.infinity,
        height: 200,
        fit: BoxFit.fill,)
                : Placeholder(fallbackHeight: 200.0,fallbackWidth: 100.0,),
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
                        onChanged: (value) => cost = int.parse(value),

                      ),
                    ),

                    SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed:(){submit(context);},
                        style: ElevatedButton.styleFrom(primary: Colors
                            .green, shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),

                        ),),

                        child: Text('SUBMIT', style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),))
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }


}
