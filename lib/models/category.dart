import 'package:flutter/material.dart';
import 'dart:ui';

class Category{
  String name;

  Color color;
  String imgName;
  List<Category> subCategories;

  Category(
      {required this.color,
        required this.name,
        required this.imgName,
         required this.subCategories,
      }
      )
  {

  }

}

