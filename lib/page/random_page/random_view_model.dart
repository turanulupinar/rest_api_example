import 'dart:convert';


import 'package:rest_api_example/model/random_model.dart';

import 'package:rest_api_example/service/random_service.dart';

class RandomModelView {
  RandomModel randomModel = RandomModel();
  Future<dynamic> getRandomData() async {
    final data = await RandomService().getData();
    final convert = await jsonDecode(data);

    randomModel = RandomModel.fromJson(convert);
    return randomModel;
  }
}
