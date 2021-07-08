import 'package:flutter/material.dart';
import 'package:kisan_sahay/models/category.dart';
import 'package:kisan_sahay/models/subcategory.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';

class DetailsPage extends StatelessWidget {
Category subCategory;
DetailsPage({required this.subCategory});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(),
      body: Center(
        child:Text(this.subCategory.name),
      ),
    );
  }
}
