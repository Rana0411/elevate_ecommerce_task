import 'package:elevate_ecommerce_task/core/api/Endpoints.dart';
import 'package:elevate_ecommerce_task/models/product_model.dart';
import '../core/api/dio_consumer.dart';
import '../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../core/error/server_exception.dart';

class ProductRepository {
  final DioConsumer productDio;

  ProductRepository(this.productDio);
  Future<Either<Failure, List<ProductModel>>> getAllProducts(
    String path,
  ) async {
    try {
      final response = await productDio.get(EndPoint.products);

      final List<ProductModel> products = (response as List).map((product) {
        return ProductModel.fromJson(product);
      }).toList();

      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
