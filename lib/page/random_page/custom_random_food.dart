import 'package:flutter/material.dart';

import 'package:rest_api_example/model/random_model.dart';
import 'package:rest_api_example/page/random_page/random_detail_page.dart';
import 'package:rest_api_example/page/random_page/random_view_model.dart';

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
      height: 300,
      child: Stack(
        children: [
          if (randomFood.meals != null)
            Card(
              color: Colors.purple.shade200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 300,
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
                  ),
                  Text(
                    randomFood.meals?.first.strMeal.toString() ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if ((randomFood.meals?.first.strInstructions
                              .toString()
                              .length ??
                          5) <
                      100)
                    Text(
                        randomFood.meals?.first.strInstructions.toString() ??
                            "",
                        textAlign: TextAlign.center)
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          style: Theme.of(context).textTheme.titleSmall,
                          "${randomFood.meals?.first.strInstructions.toString().substring(0, 150)}..."),
                    )
                ],
              ),
            ),
          Positioned(
            left: 10,
            top: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              width: 50,
              height: 20,
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
          Positioned(
            right: 20,
            top: 250,
            child: SizedBox(
              width: 100,
              height: 30,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.navigate_next),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lime.shade200,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RandomdetailPage(
                                model: randomFood,
                              )));
                },
                label: const Text("gör"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
