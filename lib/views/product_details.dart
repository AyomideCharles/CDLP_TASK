import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpld_task/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetails extends StatefulWidget {
  final Product productInfo;
  const ProductDetails({super.key, required this.productInfo});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.productInfo.images![selectedImageIndex],
                height: 300.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Skeletonizer(
                  child: Container(
                    height: 300.h,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(widget.productInfo.images!.length, (
                    index,
                  ) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.productInfo.images![index],
                            ),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: selectedImageIndex == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onError,
                            width: selectedImageIndex == index ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.productInfo.title ?? '',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  if (widget.productInfo.brand != null) ...[
                    Text(
                      'Brand: ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.productInfo.brand!,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(width: 15),
                  ],
                  if (widget.productInfo.category != null) ...[
                    Text(
                      'Category: ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.productInfo.category!,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    '\$${widget.productInfo.price?.toString() ?? '0.00'}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${widget.productInfo.discountPercentage?.toString()}% OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  RatingBar.builder(
                    ignoreGestures: true,
                    initialRating: widget.productInfo.rating?.toDouble() ?? 0.0,
                    onRatingUpdate: (_) {},
                    itemSize: 15,
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.yellow),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '(${widget.productInfo.rating.toString()})',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${widget.productInfo.reviews?.length.toString() ?? ''} Reviews',
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Availability: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.productInfo.availabilityStatus ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: widget.productInfo.availabilityStatus == 'In Stock'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Stock: ${widget.productInfo.stock ?? 0}',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Description ',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
              ),
              SizedBox(height: 10),
              Text(
                widget.productInfo.description ?? '',
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  // color: Theme.of(context).colorScheme.primary,
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.productInfo.shippingInformation != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            size: 20,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.productInfo.shippingInformation!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                    if (widget.productInfo.warrantyInformation != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.verified_user,
                            size: 20,
                            color: Colors.green,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.productInfo.warrantyInformation!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                    if (widget.productInfo.returnPolicy != null)
                      Row(
                        children: [
                          Icon(
                            Icons.assignment_return,
                            size: 20,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.productInfo.returnPolicy!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Product Details',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'SKU: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(widget.productInfo.sku ?? ''),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Weight: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('${widget.productInfo.weight.toString()} KG'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Min Order Quantity: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.productInfo.minimumOrderQuantity?.toString() ?? '',
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (widget.productInfo.reviews != null &&
                  widget.productInfo.reviews!.isNotEmpty) ...[
                Text(
                  'Customer Reviews',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Column(
                  children: widget.productInfo.reviews!.map((review) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: review.rating?.toDouble() ?? 0.0,
                                onRatingUpdate: (_) {},
                                itemSize: 15,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                review.reviewerName ?? 'Anonymous',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            review.comment ?? '',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
