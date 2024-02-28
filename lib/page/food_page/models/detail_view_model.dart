import 'dart:convert';


import '../../../constant/service_constants.dart';
import '../../../service/base_service.dart';
import 'food_detail_model.dart';

class DetailViewModel {
  Future<DetailModel> getDetailData(String id) async {
    DetailModel detail = DetailModel();
    final result =
        await BaseService(baseUrl: DetailConstant.baseUrl).getData("?i=$id");
    final tek = jsonDecode(result);

    detail = DetailModel.fromJson(tek);
    return detail;
  }
}
