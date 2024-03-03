import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rest_api_example/model/random_model.dart';

class RandomdetailPage extends StatefulWidget {
  const RandomdetailPage({super.key, required this.model});

  @override
  State<RandomdetailPage> createState() => _RandomdetailPageState();
  final RandomModel? model;
}

class _RandomdetailPageState extends State<RandomdetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model?.meals?.first.strMeal.toString() ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Center(
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget
                                .model?.meals?.first.strMealThumb
                                .toString() ??
                            ""),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: const Text("Kategori"),
                    subtitle: Text(
                        widget.model?.meals?.first.strCategory.toString() ??
                            ""),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ListTile(
                    title: const Text("Mutfak"),
                    subtitle: Text(
                        widget.model?.meals?.first.strArea.toString() ?? ""),
                  ),
                  const Text("Açıklama"),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                        widget.model?.meals?.first.strInstructions.toString() ??
                            ""),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
