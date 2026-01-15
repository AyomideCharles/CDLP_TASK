import 'package:cpld_task/models/products_model.dart';
import 'package:cpld_task/services/api_product_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  var isLoading = false.obs;
  var products = <Product>[].obs;

  getProducts() async {
    try {
      isLoading.value = true;
      final service = await ApiProductService().getProducts();
      if (service.isNotEmpty) {
        products.value = service;
        print('Fetched ${service.length} products');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      products.assignAll(products);
      return;
    }

    products.assignAll(
      products.where((product) {
        final title = product.title?.toLowerCase() ?? '';
        final brand = product.brand?.toLowerCase() ?? '';
        final category = product.category?.toLowerCase() ?? '';

        return title.contains(query.toLowerCase()) ||
            brand.contains(query.toLowerCase()) ||
            category.contains(query.toLowerCase());
      }).toList(),
    );
  }
}
