import 'package:flutter/material.dart';
import 'package:food_app/screen/widget/bottom_Container.dart';

import '../modles/food_categories_modle.dart';
import 'detail_page.dart';
import 'home_page.dart';



class Categories extends StatelessWidget {
  Categories({required this.list});
  List<FoodCategoriesModle> list=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: GridView.count(
          shrinkWrap: false,
          primary: false,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: list
              .map(
                (e) => BottomContainer(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      image: e.image,
                      name: e.name,
                      price: e.price,
                    ),
                  ),
                );
              },
              image: e.image,
              price: e.price,
              name: e.name,
            ),
          )
              .toList()),
    );
  }
}
