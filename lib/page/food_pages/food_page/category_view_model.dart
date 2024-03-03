import 'dart:convert';

import 'package:rest_api_example/model/category_model.dart';

import '../../../constant/service_constants.dart';
import '../../../service/base_service.dart';

class CategoryViewModel {
  Future<CategoryModel> getDetailData() async {
    CategoryModel category = CategoryModel();
    final result =
        await BaseService(baseUrl: CategoryConstant.baseUrl).getData("");

    final cat = jsonDecode(result);
    category = CategoryModel.fromJson(cat);
    return category;
  }
}
