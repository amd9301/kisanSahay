import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/HomePage.dart';
import 'package:kisan_sahay/helpers/utils.dart';
import 'package:kisan_sahay/models/category.dart';
import 'package:kisan_sahay/pages/selectedcategorypage.dart';
import 'package:kisan_sahay/widgets/categorybottombar.dart';
import 'package:kisan_sahay/widgets/categorycard.dart';
import 'package:flutter/services.dart';

import 'Predonate.dart';
import 'cart.dart';

class CategoryListPage extends StatelessWidget {


  List<Category>  categories =Utils.getMockedCategories();

  @override
  Widget build(BuildContext context) {
    // !!!! Side nav bar color changing code not working
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green[800], // navigation bar color
      statusBarColor: Colors.green[800], // status bar color
    ));
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            new UserAccountsDrawerHeader(accountName: new Text('User Name'),
              accountEmail: new Text('test@gmail.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_mCyTdVerlZkBa4mPc5wDWUXmbGcIuxaN-1FJ1kJ8BS6rq7vrD1B4Rm33wgyRRTFccwQ&usqp=CAU'),
              ),
            ),
            new ListTile(
              title: new Text('Home'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context)=> new HomePage())
                );
              },
            ),
            new ListTile(
              title: new Text('Donate Machinery'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context)=> new Disp())
                );
              },
            ),
            new ListTile(
              title: new Text('Cart'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context)=> new Cart())
                );
              },
            ),
            new ListTile(
              title: new Text('Your Orders'),
              onTap: () {},
            ),
            new ListTile(
              title: new Text('Settings'),
              onTap: () {},
            ),
            new ListTile(
              title: new Text('Sign Out'),
              onTap: () {},
            ),
          ],
        ),


      )  ,
      appBar: AppBar(
        title: Text('Kisan Sahay',
          textAlign: TextAlign.center,
          style: TextStyle(
          color: Colors.green[600],
          fontSize: 30.0,
        ),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color:Colors.green[800], ),
        actions: [
          Container(

            padding: EdgeInsets.all(10),
            child:ClipOval(
              child: Material(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.green[800]),
                  onPressed: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (BuildContext context)=> new Cart())
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children:[
            Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: Text('Select a category',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),),
              ),

              Expanded(
                  child: ListView.builder(

                      itemCount: categories.length,
                      itemBuilder: (BuildContext ctx,int  index){
                        return
                          CategoryCard(
                            category:categories[index],
                            onCardClick:(){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>
                                      SelectedCategoryPage(
                                        selectedCategory:
                                       this.categories[index],)));
                            },

                          );
                      }
                  )
              )

            ],
          ),

        ]
        ),
      )
    );
  }
}
