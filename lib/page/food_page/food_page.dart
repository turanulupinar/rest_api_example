import 'package:flutter/material.dart';

import 'package:rest_api_example/page/material_desc_page/detail_food_page.dart';

import 'package:rest_api_example/model/food_detail_model.dart';

import 'package:rest_api_example/model/food_model.dart';

import 'food_view_model.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  bool isLoading = false;
  ReceiptModels receipts = ReceiptModels();

  DetailModel model = DetailModel();

  final TextEditingController _controller = TextEditingController();
  getReceipts() async {
    setState(() {
      isLoading = true;
    });
    receipts =
        await FoodPageViewModel().getReceiptsData(query: _controller.text);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yemek Tarifleri"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                  hintText: "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ),
          ElevatedButton.icon(
              icon: isLoading == false
                  ? const SizedBox.shrink()
                  : const SizedBox(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )),
              onPressed: () async {
                if (_controller.text.isEmpty) {
                  throw Exception("Arama metni boş olamaz!");
                }
                await getReceipts();
              },
              label: const Text("Tarif getir")),
          Expanded(
              child: ListView.builder(
                  itemCount: receipts.meals?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = receipts.meals?[index];

                    return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            item?.strMealThumb ?? "",
                          ),
                        ),
                        title: Text(item?.strMeal ?? ""),
                        subtitle: Text(
                            "Kategori: ${item?.strCategory}  ${item?.strArea} Mutfağı"),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () async {
                            if (item?.idMeal != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                if (model.meals == null) {
                                  return DetailFoodPage(
                                    idNo: item?.idMeal,
                                  );
                                }
                                return const SizedBox(
                                  child: Text("data"),
                                );
                              }));
                            }
                          },
                        ));
                  }))
        ],
      ),
    );
  }
}


  //TODO www.themealdb.com/api/json/v1/1/lookup.php?i=52772
                              // Bu link yemek tarifinin detayını getiren link
                              // i parametresi yemek tarifi idsini alır
                              // Tarif detay sayfası
                              // fotosu, adı, ülkesi, kategorisi ve tarif detayı
                              // yazacak bir sayfa tasarla verileri bu apiden cek
                              











                                //  materialUrl: item?.strMealThumb,
  //                                 url: item?.strMealThumb,
  //                                 mealName: item?.strMeal.toString(),
  //                                 category: item?.strCategory,
  //                                 recip: item?.strInstructions,
  //                                 country: item?.strArea,
  //                                 mealMaterials: [
  //                                   item?.strIngredient1,
  //                                   item?.strIngredient2,
  //                                   item?.strIngredient3,
  //                                   item?.strIngredient4,