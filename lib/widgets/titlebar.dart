import 'package:flutter/material.dart';

class TitleBar extends StatefulWidget implements PreferredSizeWidget{

  @override
  _TitleBarState createState() => _TitleBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  new Size.fromHeight(80);
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
              child: Icon(Icons.supervised_user_circle_rounded),
            ),
          )
        ],
      ),
    );
  }
}
