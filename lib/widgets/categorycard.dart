import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kisan_sahay/models/category.dart';
import 'package:translator/translator.dart';
import 'package:kisan_sahay/globals.dart' as globals;

class CategoryCard extends StatelessWidget {
  String url;
  String name;
  Function onCardClick;

  CategoryCard({required this.url,required this.name,required this.onCardClick});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        this.onCardClick();
      } ,
      child: Container(
        margin: EdgeInsets.all(20.0),
        height: 150,
        child: Stack(
          children: [
            Positioned.fill(
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(
                      color: Colors.green,
                    )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                )
            ),
            Positioned(
              bottom:0,
              left:0,
              right:0,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius:BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ]
                    )
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding:EdgeInsets.all(10),
                child: Row(
                  children: [
                    FutureBuilder(
                        future: this.name.translate(to: globals.lang).then((value) =>  value.text),
                        initialData:this.name,
                        builder: (BuildContext context, AsyncSnapshot<String> text) {
                          return  Text(text.data.toString(),textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25
                            ),);
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
