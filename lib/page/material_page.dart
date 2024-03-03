import 'package:flutter/material.dart';
import 'package:rest_api_example/page/food_pages/detail_food_page/material_view_model.dart';
import 'package:rest_api_example/model/material_model.dart';

class MatPage extends StatefulWidget {
  const MatPage({super.key});

  @override
  State<MatPage> createState() => _MatPageState();
}

class _MatPageState extends State<MatPage> {
  MaterialModel model = MaterialModel();

  Future<dynamic> getMaterial() async {
    model = await MaterialViewModel().getMaterialData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getMaterial();
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text("Yemek Malzemeleri"),
      ),
      body: ListView.builder(
          itemCount: model.meals?.length ?? 0,
          itemBuilder: (context, index) {
            Meals? item = model.meals?[index];
            return ListTile(
                leading: Text(
                  item?.idIngredient.toString() ?? "",
                ),
                title: Text(item?.strIngredient.toString() ?? "",
                    style: Theme.of(context).textTheme.titleLarge),
                subtitle: Text(
                    item?.strDescription.toString() ?? "Detay bulunamadı!"));
          }),
    );
  }
}
