import 'dart:convert';


import '../../constant/service_constants.dart';
import '../../service/base_service.dart';
import '../../model/food_model.dart';

class FoodPageViewModel {
  final receiptsBaseUrl = ReceiptConstants.baseUrl;
  final searchPath = ReceiptConstants.search;

  Future<ReceiptModels> getReceiptsData({required String query}) async {
    ReceiptModels receipts = ReceiptModels();
    final res = await BaseService(baseUrl: receiptsBaseUrl)
        .getData("${ReceiptConstants.search}?s=$query");

    final meal = jsonDecode(res);

    receipts = ReceiptModels.fromJson(meal);

    return receipts;
  }
}


