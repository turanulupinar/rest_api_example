import 'package:rest_api_example/constant/service_constants.dart';
import 'package:http/http.dart' as http;

class RandomService {
  Future<dynamic> getData() async {
    final Uri url = Uri.parse(RandomConstant.baseUrl);
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      return responce.body;
    }
    return "bağlantı yok";
  }
}
