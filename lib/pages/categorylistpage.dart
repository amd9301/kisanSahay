import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/helpers/utils.dart';
import 'package:kisan_sahay/models/category.dart';
import 'package:kisan_sahay/pages/selectedcategorypage.dart';
import 'package:kisan_sahay/widgets/categorybottombar.dart';
import 'package:kisan_sahay/widgets/categorycard.dart';

class CategoryListPage extends StatelessWidget {


  List<Category>  categories =Utils.getMockedCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
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
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(10),
            child: ClipOval(
              child: Icon(Icons.supervised_user_circle_rounded),
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
                      padding: EdgeInsets.only(bottom: 60),
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
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:
                CategoryBottomBar(),
            )
        ]
        ),
      )
    );
  }
}
