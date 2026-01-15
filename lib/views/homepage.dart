import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpld_task/controllers/products_controller.dart';
import 'package:cpld_task/views/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controllers/auth_controller.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final authController = Get.find<AuthController>();
  final productController = Get.put(ProductsController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    authController.userProfile.value.image ??
                        'https://via.placeholder.com/150',
                  ),
                ),
                title: Text(
                  'Welcome ${authController.userProfile.value.firstName ?? ''}!',
                ),
                subtitle: Text('Explore the app to find new features.'),
              ),
              SizedBox(height: 30),

              // SizedBox(height: 30),
              Expanded(
                child: Obx(() {
                  if (productController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (productController.products.isEmpty) {
                    return Center(child: Text('No products available.'));
                  }

                  return GridView.builder(
                    itemCount: productController.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.54,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      final product = productController.products[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ProductDetails(productInfo: product),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                product.thumbnail != null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondaryContainer,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              product.thumbnail!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: product.thumbnail!,
                                          height: 160.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Skeletonizer(
                                                child: Container(
                                                  height: 120.h,
                                                  width: double.infinity,
                                                  color: Colors.white,
                                                ),
                                              ),
                                        ),
                                      )
                                    : Container(
                                        height: 160.h,
                                        width: double.infinity,
                                        color: Colors.grey.shade200,
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 50.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: Colors.red,
                                    ),
                                    child: Text(
                                      '${product.discountPercentage.toString()} %',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Icon(
                                    Iconsax.heart,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              product.title ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            if (product.brand != null)
                              Text(
                                product.brand!,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13.sp,
                                ),
                              ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  product.rating?.toString() ?? '0.0',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '(${product.reviews?.length ?? 0})',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$ ${product.price.toString()}',
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
