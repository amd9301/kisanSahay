import 'package:kisan_sahay/models/category.dart';
import 'package:flutter/material.dart';
class Utils{
  static List<Category> getMockedCategories()
  {
    return[
      Category(
          color:Colors.black,
          name:"Cultivator",
          imgName:"cultivators",
          subCategories:[
            Category(
                color:Colors.black,
                name:"Cultivator",
                imgName:"cultivator1",
                subCategories:[]
            ),
            Category(
                color:Colors.black,
                name:"Cultivator",
                imgName:"cultivator2",
                subCategories:[]
            ),
            Category(
                color:Colors.black,
                name:"Cultivator",
                imgName:"cultivator3",
                subCategories:[]
            ),
            Category(
                color:Colors.black,
                name:"Cultivator",
                imgName:"cultivator4",
                subCategories:[]
            ),
            Category(
                color:Colors.black,
                name:"Cultivator",
                imgName:"cultivator5",
                subCategories:[]
            ),
            Category(
                color:Colors.black,
                name:"Cultivator",
                imgName:"cultivator1",
                subCategories:[]
            ),

          ]
      ),
      Category(
          color:Colors.black,
          name:"Planters",
          imgName:"planters",
          subCategories:[]
      ),
      Category(
          color:Colors.black,
          name:"Plough",
          imgName:"plough",
          subCategories:[]
      ),
      Category(
          color:Colors.black,
          name:"Wheel Table Scrapers",
          imgName:"scrapers",
          subCategories:[]
      ),

      Category(
          color:Colors.black,
          name:"Tractors",
          imgName:"tractor",
          subCategories:[]
      ),
      Category(
          color:Colors.black,
          name:"Weeders",
          imgName:"weeders",
          subCategories:[]
      ),

    ];
  }
}