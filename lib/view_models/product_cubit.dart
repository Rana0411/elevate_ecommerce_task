import 'package:bloc/bloc.dart';
import 'package:elevate_ecommerce_task/core/api/Endpoints.dart';
import 'package:elevate_ecommerce_task/models/product_model.dart';
import 'package:elevate_ecommerce_task/repositories/products_repository.dart';
import 'package:meta/meta.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit(this.productRepository) : super(ProductInitial());

  Future<void> getAllProducts() async {
    emit(ProductLoading());
    final products = await productRepository.getAllProducts(EndPoint.products);
    products.fold(
      (failure) => emit(ProductFailure(errorMessage: failure.message)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }
  void toggleFavorite(int productId) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;

      List<int> updatedFavorites = List.from(currentState.favoriteIds);

      if (updatedFavorites.contains(productId)) {
        updatedFavorites.remove(productId);
      } else {
        updatedFavorites.add(productId);
      }

      emit(currentState.copyWith(favoriteIds: updatedFavorites));
    }
  }
}
