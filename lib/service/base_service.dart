import 'package:http/http.dart' as http;

import 'package:rest_api_example/constant/service_constants.dart';

class BaseService {
  // Verileri al
  Future<dynamic> getData(String path) async {
    // https://jsonplaceholder.typicode.com/users
    final Uri url = Uri.parse(ServiseContants.baseUrl + path);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Bağlantı başarılı olduğundan 200 döner
      return response.body;
    }
    return "Bağlantı Sağlanamadı! Response Status Code: ${response.statusCode}";
  }
}
