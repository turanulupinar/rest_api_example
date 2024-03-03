import 'package:flutter/material.dart';
import 'package:rest_api_example/page/material_desc_page/material_view_model.dart';
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
                setState(() {});
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text("Yemek Malzemeleri"),
      ),
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              width: 400,
              child: ListView.builder(
                  itemCount: model.meals?.length,
                  itemBuilder: (context, index) {
                    var material = model.meals?[index];
                    return ListTile(
                      leading: Text(
                        material?.idIngredient.toString() ?? "",
                      ),
                      title: Text(material?.strIngredient.toString() ?? "",
                          style: Theme.of(context).textTheme.titleLarge),
                      subtitle: material?.strDescription?[index] != null
                          ? Text(material?.strDescription.toString() ?? "")
                          : const Text(""),
                    );
                  })),
        ],
      ),
    );
  }
}
