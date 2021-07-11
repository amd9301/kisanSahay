import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PersonalPage extends StatefulWidget {
  final String url;
  PersonalPage({Key ?key,required this.url}) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState(url);
}

class _PersonalPageState extends State<PersonalPage> {
  String url;

  _PersonalPageState(this.url);
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
      // String displayName=
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(_auth.currentUser!.uid);
      UploadTask uploadTask = ref.putFile(_imagefile);

      await uploadTask.whenComplete(() async {
        _imageurl = await uploadTask.snapshot.ref.getDownloadURL();
      });

      await _auth.currentUser!.updatePhotoURL(_imageurl);
      Navigator.pop(context);

    } catch (error) {
      print(error);
    }


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child:
            Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  GestureDetector(onTap: (){
                    Navigator.pop(context);
                    },
                        child: Container
                          (
                          height: 50, width: 50 ,
                          child: Icon(Icons.arrow_back_ios_outlined, size: 24,color: Colors.black54,),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(10))),),

                  ),

                  Text('Edit Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                 SizedBox(width: 25,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0,0 ,50),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    child: ClipOval(child:  (done == false)?Image.network(url, height: 150, width: 150, fit: BoxFit.cover,):Image.file( _imagefile,height: 150, width: 150, fit: BoxFit.cover,),),
                  ),
                  Positioned(bottom: 1, right: 1 ,
                      child: Container(
                    height: 40, width: 40,
                    child: GestureDetector(
                      onTap: (){
                      pickImage();
                      },
                      child:  Icon(Icons.add_a_photo, color: Colors.white,)),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ))
                ],
              ),
            ),
             Expanded
              (
                child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.green, Color.fromRGBO(0, 41, 102, 1)]
                  )
              ),
                child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new TextFormField(
                           // onChanged: (val) => _auth.currentUser!.displayName = val,
                            //_auth.currentUser!.displayName.toString(),
                          ),
                        ),
                      ), decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_auth.currentUser!.email.toString(), style: TextStyle(color: Colors.white70),),
                        ),
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20,0),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Type something about yourself', style: TextStyle(color: Colors.white70),),
                        ),
                      ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_auth.currentUser!.phoneNumber.toString(), style: TextStyle(color: Colors.white70),),
                        ),
                      ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                    ),
                  ),*/
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: (){
                          submit(context);},
                        child: Container( height: 50, width: 180,
                          child: Align(child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 30),),),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.all( Radius.circular(30),)
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
            )
      ],
    ),
        ),

    );
  }
}