import 'package:flutter/material.dart';
import 'package:kisan_sahay/pages/cart.dart';

class TitleBar extends StatefulWidget implements PreferredSizeWidget{

  @override
  _TitleBarState createState() => _TitleBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  new Size.fromHeight(60);
}

class _TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('   Kisan Sahay',
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
              child: Material(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.green[600]),
                  onPressed: () {Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context)=> new Cart())
                  );},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
