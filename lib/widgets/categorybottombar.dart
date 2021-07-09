import 'package:flutter/material.dart';

class CategoryBottomBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.2),
                offset: Offset.zero
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipOval(
            child: Material(
              child: IconButton(
                icon: Icon(Icons.favorite_rounded, color: Colors.green[600]),
                onPressed: () {},
              ),
            ),
          ),
          ClipOval(
            child: Material(
              child: IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.green[600],),
                onPressed: () {},
              ),
            ),
          ),
          ClipOval(
            child: Material(
              child: IconButton(
                icon: Icon(Icons.pin_drop, color: Colors.green[600]),
                onPressed: () {},
              ),
            ),
          ),
          ClipOval(
            child: Material(
              child: IconButton(
                icon: Icon(Icons.settings, color: Colors.green[600]),
                onPressed: () {},
              ),
            ),
          ),


        ],
      ),
    );
  }
}
