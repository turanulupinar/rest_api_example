import 'package:http/http.dart' as http;

import 'package:rest_api_example/constant/service_constants.dart';

// Get, Post, Put, Delete = CRUD { Create, Read, Update, Delete} işlemleri
class BaseService {
  //API'den Verileri al
  Future<dynamic> getData(String path) async {
    final Uri url = Uri.parse(ServiseContants.baseUrl + path);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Bağlantı başarılı olduğundan 200 döner
      return response.body;
    }
    return "Bağlantı Sağlanamadı! Response Status Code: ${response.statusCode}";
  }

// API'ye Veri Gönder
  Future<http.Response> postData(
      {required String path, required dynamic body}) async {
    final response = await http.post(Uri.parse(ServiseContants.baseUrl + path),
        headers: postHeader, body: body);
    return response;
  }

  Map<String, String> postHeader = {
    'Content-type': 'application/json; charset=UTF-8',
  };

// API'deki bir bir veriyi güncelleme
  Future<http.Response> putData(
      {required String path, required dynamic body}) async {
    final response = await http.put(Uri.parse(ServiseContants.baseUrl + path),
        headers: postHeader, body: body);
    return response;
  }

  // API'deki bir veriyi silme işlemi
  Future<http.Response> deleteData({required String path, required id}) async {
    final response = await http.delete(
      Uri.parse("${ServiseContants.baseUrl}$path/$id"),
    );
    return response;
  }
}
