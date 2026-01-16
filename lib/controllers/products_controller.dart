import 'package:cpld_task/models/products_model.dart';
import 'package:cpld_task/models/single_product_model.dart';
import 'package:cpld_task/services/api_product_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  var isLoading = false.obs;
  var products = <Product>[].obs;
  var selectedProduct = Rxn<SingleProductModel>();
  var isLoadingSingleProduct = false.obs;

  getProducts() async {
    try {
      isLoading.value = true;
      final service = await ApiProductService().getProducts();
      if (service.isNotEmpty) {
        products.value = service;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getEachProduct(int id) async {
    try {
      isLoadingSingleProduct.value = true;
      final response = await ApiProductService().singleProduct(id);
      if (response != null) {
        selectedProduct.value = response;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingSingleProduct.value = false;
    }
  }
}
