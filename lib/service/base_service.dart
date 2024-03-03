import 'package:http/http.dart' as http;

import 'package:rest_api_example/constant/service_constants.dart';

// Get, Post, Put, Delete = CRUD { Create, Read, Update, Delete} işlemleri
class BaseService {
  final String baseUrl;
  BaseService({this.baseUrl = ServiseContants.baseUrl});

  //API'den Verileri al
  Future<dynamic> getData(String path) async {
     Uri url = Uri.parse(baseUrl + path);

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
    final response = await http.post(Uri.parse(baseUrl + path),
        headers: postHeader, body: body);
    return response;
  }

  Map<String, String> postHeader = {
    'Content-type': 'application/json; charset=UTF-8',
  };

// API'deki bir bir veriyi güncelleme
  Future<http.Response> putData(
      {required String path, required dynamic body}) async {
    final response = await http.put(Uri.parse(baseUrl + path),
        headers: postHeader, body: body);
    return response;
  }

  // API'deki bir veriyi silme işlemi
  Future<http.Response> deleteData({required String path, required id}) async {
    final response = await http.delete(
      Uri.parse("$baseUrl$path/$id"),
    );
    return response;
  }


}

/// API Hakkında Genel Not

// Sipariş apisi
// https://www.xstore.com/api/order   (SSL Secured)

// http://www.xstore.com/api/order    (No SSL)

// Subdomain version
// https://     api          .xstore      .com    /order      ?     orderId=3
// protocol  subdomain     domain name   uzantı    path     query   parametre

// GET    ->  Siparişlerimi çekebilirim
// POST   ->  Sipariş vermek için kullanılabilir
// PUT    ->  Siparişimi güncelleyebilirim
// DELETE ->  Siparişi silmek veya iptal etmek için kullanılabilir


// Peki nasıl istek atılabilir?
// path: "api/order"
// header: {"x":"Özel bilgi","content-type":"Application/json","Accept":"*/*","locale":"tr-TR"}
// body: {"X":"Data","Y":"Data2"}
// query: {"orderId":"12345"}


// Yukarıdaki bilgiler genel verilerdir. İletişim kurulan Backend servisine göre değişkenlik gösterir

