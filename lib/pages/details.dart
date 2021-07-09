import 'package:flutter/material.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:kisan_sahay/models/category.dart';
import 'package:kisan_sahay/models/subcategory.dart';
class DetailsPage extends StatefulWidget {
   Category subCategory;
   DetailsPage({required this.subCategory});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {


  Widget build(BuildContext context) {


    return Scaffold(
      appBar: TitleBar(),
      body:Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              child: Stack(
                children: [

                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/'+widget.subCategory.imgName+'.png'),
                          fit: BoxFit.cover,
                        )
                    ),
                  ) ,
                  Positioned.fill(
                      child:
                     Container(
                       decoration: BoxDecoration(
                             gradient: LinearGradient(
                               begin:     Alignment.bottomCenter,
                             end: Alignment.topCenter
                             , colors: [
                                   Colors.black.withOpacity(0.6),
                                   Colors.transparent
                             ])
                       ),

                  )
                  ) ,
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right:0 ,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:
                              [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [

                                            Text('Machinery Type',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20
                                            )
                                              ,) ,
                                    SizedBox(height: 10,),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                         decoration:
                                         BoxDecoration
                                           (
                                              color: widget.subCategory.color,
                                             borderRadius: BorderRadius.circular(20),
                                           ),
                                             child:Text('₹1000/per day',
                                             style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                             ),)

                                    )
                                  ],
                                )

                              ],

                        ),
                      ))

                ],

              ),
            ),
            SizedBox(height: 20,),
            Expanded(
                child:
                Container(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Text('Please Select the Date:',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                     SizedBox(height: 20),

                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed:(){},
                                style: ElevatedButton.styleFrom(primary: Colors
                                    .green, shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),

                                ),),

                                child: Text(' Rent Now  ', style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),)
                            ),
                            SizedBox(width: 50,),
                            ElevatedButton(
                                onPressed:(){},
                                style: ElevatedButton.styleFrom(primary: Colors
                                    .green, shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),

                                ),),

                                child: Text('Add to Cart', style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),))
                          ],
                        ),
                      )

                    ],
                  )

                ))

          ],
        ),
      ),
    );
  }
}
