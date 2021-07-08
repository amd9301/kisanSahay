
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kisan_sahay/helpers/utils.dart';
import 'package:kisan_sahay/pages/categorylistpage.dart';
import 'package:duration/duration.dart';
import 'package:kisan_sahay/pages/selectedcategorypage.dart';
import 'Login.dart';
import 'Start.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent
      ),
      //home: Start(),
      home: SelectedCategoryPage(selectedCategory: Utils.getMockedCategories()[0],),

    );
  }
}

