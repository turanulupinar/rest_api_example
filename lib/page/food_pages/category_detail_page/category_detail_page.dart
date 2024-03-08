import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rest_api_example/model/category_model.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  CategoryModel model = CategoryModel();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategoriler"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
                widget.categoryModel.categories?.length ?? 5,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: 375,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.deepPurpleAccent.shade100,
                          ),
                          child: Center(
                            child: ListTile(
                              dense: true,
                              leading: Container(
                                height: 250,
                                width: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(widget
                                                .categoryModel
                                                .categories?[index]
                                                .strCategoryThumb
                                                .toString() ??
                                            ""))),
                              ),
                              title: Text(
                                widget.categoryModel.categories?[index]
                                        .strCategoryDescription
                                        .toString() ??
                                    "",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
