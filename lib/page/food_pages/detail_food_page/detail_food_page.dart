import 'package:flutter/material.dart';
import 'package:rest_api_example/model/detail_view_model.dart';
import 'package:rest_api_example/model/food_detail_model.dart';

import '../../../widgets/custom_loading_widget.dart';

class DetailFoodPage extends StatefulWidget {
  const DetailFoodPage({super.key, this.idNo});

  @override
  State<DetailFoodPage> createState() => _DetailFoodPageState();
  final String? idNo;
}

class _DetailFoodPageState extends State<DetailFoodPage> {
  DetailModel detailModel = DetailModel();
  List<String> measureList = [];
  List<String> ingredientList = [];
  List<Map<String, String>> measureAndIngredientList = [];
  bool isLoading = true;

  @override
  void initState() {
    getDetail();

    super.initState();
  }

  getDetail() async {
    detailModel = await DetailViewModel().getDetailData(widget.idNo ?? "52772");

    measureAndIngredientList = [
      {
        "measure": detailModel.meals?.first.strMeasure1.toString() ?? "",
        "ingredient": detailModel.meals?.first.strIngredient1.toString() ?? ""
      },
      {
        "measure": detailModel.meals?.first.strMeasure2.toString() ?? "",
        "ingredient": detailModel.meals?.first.strIngredient2.toString() ?? ""
      },
      {
        "measure": detailModel.meals?.first.strMeasure3.toString() ?? "",
        "ingredient": detailModel.meals?.first.strIngredient3.toString() ?? ""
      },
      {
        "measure": detailModel.meals?.first.strMeasure4.toString() ?? "",
        "ingredient": detailModel.meals?.first.strIngredient4.toString() ?? ""
      },
      {
        "measure": detailModel.meals?.first.strMeasure5.toString() ?? "",
        "ingredient": detailModel.meals?.first.strIngredient5.toString() ?? ""
      }
    ];

    setState(() {
      isLoading = false;
    });
  }

  String editTag() {
    var tag = detailModel.meals?.first.strTags;
    if ((tag?.split(",").length ?? 5) > 1) {
      return "#${tag?.split(",").join("  #").toLowerCase() ?? ""}";
    }

    return "#${tag?.toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const CustomLoadingWidget()
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  centerTitle: true,
                  floating: false,
                  flexibleSpace: Image.network(
                    detailModel.meals?.first.strMealThumb.toString() ??
                        "https://cdn.pixabay.com/photo/2022/05/22/15/02/pizza-7213599_1280.jpg",
                    fit: BoxFit.cover,
                  ),
                  expandedHeight: 350,
                  title: Text(
                      detailModel.meals?.first.strMeal.toString() ?? "grwgs",
                      style: Textstl.titlestyle.styleFunc(context)),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red.shade200),
                                child: Text(
                                  detailModel.meals?.first.strCategory
                                          .toString() ??
                                      "",
                                  style: Textstl.bodyMedium.styleFunc(context),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              Container(
                                  width: 120,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.red.shade200),
                                  child: Text(
                                    "${detailModel.meals?.first.strArea.toString()}",
                                    style: Textstl.bodyLarge.styleFunc(context),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Malzemeler",
                            style: Textstl.mealTitle.styleFunc(context),
                          ),
                          ...List.generate(measureAndIngredientList.length,
                              (index) {
                            var kef = measureAndIngredientList[index];

                            return ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(detailModel
                                          .meals?.first.strMealThumb
                                          .toString() ??
                                      "")),
                              title: Row(
                                children: [
                                  Text(kef.values.first.toString()),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(kef.values.last.toString()),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Hazırlanışı",
                            style: Textstl.mealTitle.styleFunc(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(detailModel.meals?.first.strInstructions
                                    .toString() ??
                                ""),
                          ),
                          const Divider(
                            endIndent: 50,
                            height: 5,
                            indent: 50,
                            thickness: 5,
                          ),
                          const SizedBox(height: 20),
                          if (detailModel.meals?.first.strTags?.isNotEmpty ==
                              true)
                            Text(editTag()),
                          const SizedBox(height: 20)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

enum Textstl { bodyMedium, bodyLarge, titlestyle, mealTitle }

extension TextstlX on Textstl {
  styleFunc(BuildContext context) {
    switch (this) {
      case Textstl.bodyMedium:
        return Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 18,
            );
      case Textstl.bodyLarge:
        return Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 18,
            );
      case Textstl.titlestyle:
        return Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            );
      case Textstl.mealTitle:
        return Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            );
      default:
        return "stil yok";
    }
  }
}
