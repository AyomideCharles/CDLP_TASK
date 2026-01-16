class ApiUrls {
  static const String login = "https://dummyjson.com/auth/login";
  static const String userInfo = "https://dummyjson.com/auth/me";
  static const String products = "https://dummyjson.com/products";
  static String singleProduct(int id) => "https://dummyjson.com/products/$id";
}
