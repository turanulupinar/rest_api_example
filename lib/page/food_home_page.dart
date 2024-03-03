import 'package:flutter/material.dart';
import 'package:rest_api_example/page/random_page/custom_random_food.dart';

import 'food_page/category_view_model.dart';
import 'material_desc_page/detail_food_page.dart';
import '../model/category_model.dart';

class FoodHomePage extends StatefulWidget {
  const FoodHomePage({super.key});

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  CategoryModel catModel = CategoryModel();
  RandomFoodCard foodCard = const RandomFoodCard();
  getCategories() async {
    catModel = await CategoryViewModel().getDetailData();
    setState(() {});
  }

  @override
  void initState() {
    getCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anasayfa"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
           
            foodCard,
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Kategoriler",
                    style: Textstl.mealTitle.styleFunc(context),
                  )),
            ),
            SizedBox(
              height: 200,
              width: 450,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: catModel.categories?.length,
                  itemBuilder: (context, index) {
                    final item = catModel.categories?[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        item?.strCategoryThumb ?? ""))),
                          ),
                          Text(item?.strCategory.toString() ?? "")
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
