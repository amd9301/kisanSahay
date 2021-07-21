
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'package:kisan_sahay/helpers/utils.dart';
import 'package:kisan_sahay/pages/categorylistpage.dart';
import 'package:duration/duration.dart';
import 'package:kisan_sahay/pages/details.dart';
import 'package:kisan_sahay/pages/selectedcategorypage.dart';
import 'Login.dart';
import 'Start.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var islogin=prefs.getBool('isLoggedin');
  print(islogin);
  runApp(MaterialApp(home: islogin==true ?HomePage() : MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent
      ),
      home: Start(),
      //home: ,
      //home: SelectedCategoryPage(selectedCategory: Utils.getMockedCategories()[0],),
      /*home: DetailsPage(
        subCategory: Utils.getMockedCategories()[0].subCategories[0],
      ),*/
    );
  }
}

