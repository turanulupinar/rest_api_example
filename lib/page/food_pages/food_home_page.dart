import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:rest_api_example/page/food_pages/random_page/custom_random_food.dart';
import 'package:rest_api_example/widgets/custom_loading_widget.dart';

import 'category_detail_page/category_detail_page.dart';
import 'food_page/category_view_model.dart';
import 'detail_food_page/detail_food_page.dart';
import '../../model/category_model.dart';

class FoodHomePage extends StatefulWidget {
  const FoodHomePage({super.key});

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  CategoryModel catModel = CategoryModel();
  RandomFoodCard foodCard = const RandomFoodCard();
  
  getCategories() async {
    setState(() {});
   
    await Future.delayed(const Duration(seconds: 2));

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
                            padding: const EdgeInsets.all(9),
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              height: 100,
                              width: 150,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                        
                                        
                                                CategoryDetailPage(
                                                      categoryModel: catModel,
                                                    )));
                                },
                                child: CachedNetworkImage(
                                  imageUrl: item?.strCategoryThumb ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
