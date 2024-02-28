import 'package:flutter/material.dart';

import 'food_page/category_view_model.dart';
import 'material_desc_page/detail_food_page.dart';
import 'food_page/models/category_model.dart';

class FoodHomePage extends StatefulWidget {
  const FoodHomePage({super.key});

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  CategoryModel catModel = CategoryModel();
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 350,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.pink,
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2019/03/30/20/27/pie-4091990_1280.png"),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: Text("En Lezzetli Yemekleri Sen Yap!",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(backgroundColor: Colors.white),
                    textAlign: TextAlign.center),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Kategoriler",
                    style: Textstl.mealTitle.styleFunc(context),
                  )),
            ),
            SizedBox(
              height: 200,
              width: 350,
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
