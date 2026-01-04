import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_models/product_cubit.dart';
import '../widgets/product_card.dart';

class ProductsHomeScreen extends StatefulWidget {
  const ProductsHomeScreen({super.key});

  @override
  State<ProductsHomeScreen> createState() => _ProductsHomeScreenState();
}

class _ProductsHomeScreenState extends State<ProductsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products"), centerTitle: true),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },

        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return GridView.builder(
              padding:  EdgeInsets.all(16.h),
              itemCount: state.products.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 285.h,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: state. products[index]);
              },
            );
          } else if (state is ProductFailure) {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<ProductCubit>().getAllProducts(),
                child: const Text("Please Try Again!"),
              ),
            );
          }

          return const Center(child: Text("Start discovering products!"));
        },
      ),
    );
  }
}
