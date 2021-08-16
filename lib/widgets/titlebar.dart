import 'package:flutter/material.dart';
import 'package:kisan_sahay/pages/cart.dart';
import 'package:kisan_sahay/globals.dart' as globals;

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
        title: Text('Kisan Sahay',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.green[600],
            fontSize: 25.0,
          ),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        iconTheme: IconThemeData(color:Colors.green[800], ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.fromLTRB(0,0,0,0),
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
          ),
          Container(
            margin: EdgeInsets.only(right: 6),
            padding: EdgeInsets.fromLTRB(0,0,0,0),
            child: ClipOval(
              child: IconButton(
                icon: Icon(Icons.translate_rounded, color: Colors.green[600]),
                onPressed: () {
                  setState(() {
                    if(globals.lang=="te")globals.lang="en";
                    else globals.lang="te";
                    print(globals.lang);
                    // changelang();
                  });
                },
              ),
            ),
          )

        ],
      ),
    );
  }
}
