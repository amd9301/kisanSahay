import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'l10n/L10n.dart';
import 'Start.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var islogin=prefs.getBool('isLoggedin');
  print(islogin);
  runApp(MaterialApp(home: islogin==true ?HomePage() : MyApp()));
}

class MyApp extends StatelessWidget {
  static final String title ='Localization';
  @override
  Widget build(BuildContext context) {
   // var data = EasyLocalizationProvider.of(context).data;
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent
        ),
        /*supportedLocales: L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],*/
        home: Start(),
        //home: ,
        //home: SelectedCategoryPage(selectedCategory: Utils.getMockedCategories()[0],),
        /*home: DetailsPage(
          subCategory: Utils.getMockedCategories()[0].subCategories[0],
        ),*/
      
    );
  }
}

