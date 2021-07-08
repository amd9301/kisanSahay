import 'package:flutter/material.dart';
import 'package:kisan_sahay/models/category.dart';

class CategoryCard extends StatelessWidget {
   Category category;
   Function onCardClick;

  CategoryCard({required this.category,required this.onCardClick});
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
                  child: Image.asset(
                    'assets/images/'+this.category.imgName+'.jpg',
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
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
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
                    Text(
                      this.category.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      ),
                    )
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
