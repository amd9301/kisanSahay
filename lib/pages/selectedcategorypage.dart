import 'package:flutter/material.dart';
import 'package:kisan_sahay/models/category.dart';
import 'package:kisan_sahay/pages/details.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';

class SelectedCategoryPage extends StatelessWidget {
Category selectedCategory;
SelectedCategoryPage({required this.selectedCategory}){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(),
      body: Container(
     child: Column(
       children: [
         Row( 
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(height: 40,),
             Text(this.selectedCategory.name,
             style: TextStyle(
               color: this.selectedCategory.color,fontSize: 20
             ),)
           ],
         ),
         SizedBox(height: 10,),
         Expanded(child: GridView.count(crossAxisCount: 2,
         children: List.generate(this.selectedCategory.subCategories.length,
        (index) {
           return GestureDetector(
             onTap:(){
               // To do : Navigate to the details page
               Navigator.push(context,
               MaterialPageRoute(
                   builder: (context) =>
                       DetailsPage(
                           subCategory: this.selectedCategory.subCategories[index],
                       )
               )
               );
             } ,
             child: Container(
               child: Column(
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(10.0),
                     child: Image.asset('assets/images/'+this.selectedCategory.subCategories[index].imgName+'.png',
                     fit: BoxFit.cover,width: 120,height: 120,
                     ),
                   ),
                   SizedBox(height: 10,),
                   Text(this.selectedCategory.subCategories[index].name,
                   style: TextStyle(
                     color: this.selectedCategory.color

                   ),)
                 ],
               ),
             ),
           );
                  }
         ),
         ))
       ],

     ),
      ),
    );
  }
}
