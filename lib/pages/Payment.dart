import 'package:flutter/material.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';


class PayPage extends StatefulWidget {


  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {


  Widget build(BuildContext context) {

    // String url= await ;

    return Scaffold(
      appBar: TitleBar(),
      body:Container(
        child: Padding(
          padding: EdgeInsets.only(left: 50,top:40,right: 30),
          child: Column(
            children: [
              Text("Contact the Owner",
              style: TextStyle(fontSize: 30,
              color: Colors.green[900]),
              ),

            ],
          ),
        ),
      )
    );
  }
}
