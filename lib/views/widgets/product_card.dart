import 'package:elevate_ecommerce_task/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_models/product_cubit.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15.r),
                  ),
                  child: Image.network(
                    product.image ?? "",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 5.h,
                  right: 5.w,

                  child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      bool isFav = false;
                      if (state is ProductLoaded) {
                        isFav = state.favoriteIds.contains(product.id);
                      }

                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          constraints: const BoxConstraints(), // بيشيل المسافات الافتراضية للزرار
                          padding: EdgeInsets.all(4.r),
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.blue,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            context.read<ProductCubit>().toggleFavorite(product.id!);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("EGP ${product.formattedPrice}"),
                    Text(
                      "EGP ${product.formattedOldPrice}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough, // الشطب
                        decorationColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Review (${product.rating?.rate?.toString()}) ⭐"),
                    Icon(Icons.add_circle, color: Colors.blue, size: 25.sp),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
