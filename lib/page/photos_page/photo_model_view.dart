import 'dart:convert';

import 'package:rest_api_example/page/photos_page/photo_model.dart';
import 'package:rest_api_example/service/base_service.dart';

import '../../constant/service_constants.dart';

class PhotoPageViewModel {
  Future<List<PhotoModel>?> getPhotoData() async {
    List<PhotoModel>? photoList = [];
    final res = await BaseService().getData(ServiseContants.photos);

    List<dynamic> photosData = jsonDecode(res);

    photoList = photosData.map((user) => PhotoModel.fromJson(user)).toList();

    return photoList;
  }
}
