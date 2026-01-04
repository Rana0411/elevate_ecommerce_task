import '../../view_models/product_cubit.dart';
import '../../views/screens/products_home_screen.dart';
import '../di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
   static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProductCubit>()..getAllProducts(),
            child: const ProductsHomeScreen(),
          ),

        );
      default:
        return null;
    }
  }
}