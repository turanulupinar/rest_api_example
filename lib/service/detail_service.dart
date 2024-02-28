import 'package:http/http.dart' as http;


class DetailService {
  final String baseUrl;

  const DetailService(
    this.baseUrl,
  );
  Future<dynamic> getService(String path) async {
    final Uri url = Uri.parse(baseUrl + path);
    final result = await http.get(url);

    if (result.statusCode == 200) {
      result.body;
    }
    return "bağlantısağlanamadı ${result.statusCode}";
  }
}


