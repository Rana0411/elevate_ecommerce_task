part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}
final class ProductLoaded extends ProductState{

 final List<ProductModel> products;
 final List<int> favoriteIds;

  ProductLoaded(  {required this.products , this.favoriteIds =const[],});

 ProductLoaded copyWith({List<int>? favoriteIds}) {
   return ProductLoaded(
     products: products,
     favoriteIds: favoriteIds ?? this.favoriteIds,
   );
 }


}
final class ProductLoading extends ProductState{}

final class ProductFailure extends ProductState{
   final String errorMessage;

  ProductFailure({required this.errorMessage});


}



