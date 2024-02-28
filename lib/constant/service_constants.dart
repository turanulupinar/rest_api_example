class ServiseContants {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/";
  static const String users = "users";
  static const String photos = "photos?_start=0&_limit=15";
  static const String post = "posts";
  //TODO
  static const String posts = "posts?_start=0&_limit=10";
  static const String albums = "albums?_start=0&_limit=10";
}

class ReceiptConstants {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1/";
  static const String search = "search.php"; // endpoint
}

class CategoryConstant {
  static const String baseUrl =
      "https://www.themealdb.com/api/json/v1/1/categories.php";
}

class DetailConstant {
  static const String baseUrl =
      "https://www.themealdb.com/api/json/v1/1/lookup.php";
}

class ElementConstant {
  static const baseUrl = "https://www.themealdb.com/api/json/v1/1/";
  static const search = "list.php?i=";
}
