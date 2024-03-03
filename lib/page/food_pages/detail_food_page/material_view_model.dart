import 'dart:convert';

import 'package:rest_api_example/model/material_model.dart';

import '../../../service/material_service.dart';

class MaterialViewModel {
  MaterialModel matModel = MaterialModel();
  Future<MaterialModel> getMaterialData() async {
    final res = await MaterialDescService().getService("list");
    final data = jsonDecode(res);
    matModel = MaterialModel.fromJson(data);
    return matModel;
  }
}
