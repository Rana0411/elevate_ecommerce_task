import 'package:elevate_ecommerce_task/core/api/dio_consumer.dart';
import 'package:elevate_ecommerce_task/repositories/products_repository.dart';
import 'package:elevate_ecommerce_task/view_models/product_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
 final getIt =GetIt.instance;
  void setUpServiceLocator(){
     getIt.registerLazySingleton<Dio>(()=>Dio());
     getIt.registerLazySingleton<DioConsumer>(()=>DioConsumer(getIt<Dio>()));
     getIt.registerLazySingleton<ProductRepository>(()=>ProductRepository(getIt<DioConsumer>()));
     getIt.registerFactory<ProductCubit>(()=>ProductCubit(getIt<ProductRepository>()));
  }