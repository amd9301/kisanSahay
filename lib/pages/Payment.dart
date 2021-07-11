import 'package:flutter/material.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';


class PayPage extends StatefulWidget {

  const PayPage({Key? key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {


  Widget build(BuildContext context) {

    // String url= await ;

    return Scaffold(
      appBar: TitleBar(),
      body:Center(
        child: Text(
          "Payment page",
        ),
      )
    );
  }
}
