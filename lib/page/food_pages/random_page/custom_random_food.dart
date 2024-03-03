import 'package:flutter/material.dart';

import 'package:rest_api_example/model/random_model.dart';
import 'package:rest_api_example/page/food_pages/random_page/random_detail_page.dart';
import 'package:rest_api_example/page/food_pages/random_page/random_view_model.dart';
import 'package:rest_api_example/util/toast_messenger.dart';

import '../detail_food_page/detail_food_page.dart';

class RandomFoodCard extends StatefulWidget {
  const RandomFoodCard({super.key});

  @override
  State<RandomFoodCard> createState() => _RandomFoodCardState();
}

class _RandomFoodCardState extends State<RandomFoodCard> {
  RandomModel randomFood = RandomModel();
  getRandomData() async {
    randomFood = await RandomModelView().getRandomData();
    setState(() {});
  }

  @override
  void initState() {
    getRandomData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Stack(
        children: [
          if (randomFood.meals != null)
            Column(
              children: [
                Card(
                  color: Colors.purple.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    randomFood.meals?.first.strMealThumb
                                            .toString() ??
                                        "",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        Text(
                          randomFood.meals?.first.strMeal.toString() ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                        ),
                        ((randomFood.meals?.first.strInstructions
                                        .toString()
                                        .length ??
                                    5) <
                                100)
                            ? Text(
                                randomFood.meals?.first.strInstructions
                                        .toString() ??
                                    "",
                                textAlign: TextAlign.center)
                            : Text(
                                style: Theme.of(context).textTheme.titleSmall,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                "${randomFood.meals?.first.strInstructions.toString()}..."),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.navigate_next),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lime.shade200,
                            ),
                            onPressed: () {
                              if (randomFood.meals?.first.idMeal == null) {
                                CustomToast.showToast(
                                    msg: "Menü detayı bulunamadı!");
                                return;
                              }
                              
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailFoodPage(
                                            idNo:
                                                randomFood.meals?.first.idMeal,
                                          )));
                            },
                            label: const Text("Tarif Detayı"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          Positioned(
            left: 30,
            top: 30,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white70,
              ),
              width: 80,
              height: 30,
              padding: const EdgeInsets.all(8),
              child: Text(
                textAlign: TextAlign.center,
                randomFood.meals?.first.strCategory.toString() ?? "",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
