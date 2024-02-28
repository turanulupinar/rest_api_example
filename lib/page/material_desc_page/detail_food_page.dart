import 'package:flutter/material.dart';
import 'package:rest_api_example/page/food_page/models/detail_view_model.dart';
import 'package:rest_api_example/page/food_page/models/food_detail_model.dart';

class DetailFoodPage extends StatefulWidget {
  const DetailFoodPage({super.key, this.idNo});

  @override
  State<DetailFoodPage> createState() => _DetailFoodPageState();
  final String? idNo;
}

class _DetailFoodPageState extends State<DetailFoodPage> {
  DetailModel detailModel = DetailModel();
  List<Map<String, dynamic>> mealMaterials = [{}];

  @override
  void initState() {
    getDetail();

    super.initState();
  }

  getDetail() async {
    detailModel = await DetailViewModel().getDetailData(widget.idNo ?? "52772");
    setState(() {});
    mealMaterials = [
      {
        "title": detailModel.meals?.first.strIngredient1,
      }
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
            title: Text(detailModel.meals?.first.strMeal.toString() ?? "grwgs",
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
                            detailModel.meals?.first.strCategory.toString() ??
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
                    ...List.generate(mealMaterials.length, (index) {
                      //  if (mealMaterials.isNotEmpty == true) {

                      //  }

                      return ListTile(
                        leading: const CircleAvatar(
                            backgroundImage: NetworkImage("")),
                        title: Text(mealMaterials[index].toString()),
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
                      child: Text(
                          detailModel.meals?.first.strInstructions.toString() ??
                              ""),
                    ),
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
