import 'package:cpld_task/models/products_model.dart';
import 'package:cpld_task/models/single_product_model.dart';
import 'package:cpld_task/services/api_urls.dart';
import 'package:cpld_task/services/http_client.dart';

class ApiProductService {
  final ApiClient httpClient = ApiClient();

  Future<List<Product>> getProducts() async {
    final response = await httpClient.get(ApiUrls.products);

    return ProductsResponse.fromJson(response).products;
  }

  Future<SingleProductModel> singleProduct(int id) async {
    return await httpClient.get(
      ApiUrls.singleProduct(id),
      fromJson: (json) => SingleProductModel.fromJson(json),
    );
  }
}
