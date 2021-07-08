import 'dart:ui';

import 'package:kisan_sahay/models/category.dart';

class SubCategory extends Category{
  SubCategory({
    required Color color,
    required String name,
    required String imgName,
    required subCategories
}):super(
      color: color,
      name:  name,
      imgName: imgName,
       subCategories: subCategories
  );
}