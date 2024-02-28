import '../constant/service_constants.dart';
import 'package:http/http.dart' as http;
class MaterialDescService {
 Future<dynamic> getService(String intgredients) async {
    final Uri url = Uri.parse(
        ElementConstant.baseUrl + ElementConstant.search + intgredients);
    final result = await http.get(url);
    if (result.statusCode == 200) {
     return  result.body;
    }
    return "bağlantı yok";
  }
}