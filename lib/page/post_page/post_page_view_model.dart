import 'dart:convert';
import 'dart:developer';

import 'package:rest_api_example/page/post_page/models/request_post_model.dart';

import '../../constant/service_constants.dart';
import '../../service/base_service.dart';
import 'models/response_post_model.dart';

class PostPageViewModel {
  BaseService postsService = BaseService();
  Future<ResponsePostModel?> postData(RequestPostModel model) async {
    final result = await postsService.postData(
        path: ServiseContants.post, body: jsonEncode(model.toJson()));

    if (result.statusCode == 200 || result.statusCode == 201) {
      return ResponsePostModel.fromJson(jsonDecode(result.body));
    }
    return ResponsePostModel(
        success: false,
        errorMessage: "Bağlantı sağlanamadı! Hata kodu: ${result.statusCode}");
  }

  Future<ResponsePostModel?> putData(RequestPostModel model) async {
    final result = await postsService.postData(
        path: ServiseContants.post, body: jsonEncode(model.toJson()));

    if (result.statusCode == 200 || result.statusCode == 201) {
      final res = ResponsePostModel.fromJson(jsonDecode(result.body));

      return res.copyWith(success: true, errorMessage: null);
    }
    return ResponsePostModel(
        success: false,
        errorMessage: "Bağlantı sağlanamadı! Hata kodu: ${result.statusCode}");
  }

  Future<String> postDelete(dynamic id) async {
    final result =
        await postsService.deleteData(path: ServiseContants.posts, id: id);
    log(result.body.toString());
    if (result.statusCode == 200 || result.statusCode == 201) {
      return "Veri başarı ile silindi!";
    }
    return "Veri silinemedi!";
  }
}






 