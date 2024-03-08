import 'dart:developer';

import 'package:flutter/material.dart';


import 'package:rest_api_example/page/food_pages/detail_food_page/detail_food_page.dart';

import 'package:rest_api_example/model/food_detail_model.dart';

import 'package:rest_api_example/model/food_model.dart';
import 'package:rest_api_example/util/toast_messenger.dart';

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
  String searchWord = "";

  final TextEditingController _controller = TextEditingController(text: "");
  getReceipts() async {
    log("asdas");
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
              decoration: InputDecoration(
                  hintText: searchWord.toString(),
                  border: const OutlineInputBorder(
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
                  CustomToast.showToast(msg: "Lütfen bir ifade girin!");
                  return;
                }
                if (isLoading == true) return;
                await getReceipts();

                setState(() {
                 
                });
              },
              label: const Text("Tarif getir")),
          if (receipts.meals?.isNotEmpty == true)
            Expanded(
                child: ListView.builder(
                    itemCount: receipts.meals?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = receipts.meals?[index];

                      return ListTile(
                        onTap: () {
                          if (item?.idMeal == null) {
                            CustomToast.showToast(
                                msg:
                                    "Şu anda menü içeriğine ulaşılamıyor! Üzgünüz :/");
                            return;
                          }

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailFoodPage(
                                        idNo: item?.idMeal,
                                      )));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            item?.strMealThumb ?? "",
                          ),
                        ),
                        title: Text(item?.strMeal ?? ""),
                        subtitle: Text(
                            "Kategori: ${item?.strCategory}  ${item?.strArea} Mutfağı"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      );
                    }))
        ],
      ),
    );
  }
}


  







