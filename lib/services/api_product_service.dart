import 'dart:convert';

import 'package:cpld_task/models/products_model.dart';
import 'package:cpld_task/services/api_urls.dart';
import 'package:http/http.dart' as http;

class ApiProductService {
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.products),
        headers: {'Content-Type': 'application/json'},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ProductsResponse.fromJson(data).products;
      } else {
        throw (data['message'] ?? 'Failed to fetch user info');
      }
    } catch (e) {
      rethrow;
    }
  }
}
