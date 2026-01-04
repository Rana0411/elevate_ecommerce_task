import 'package:elevate_ecommerce_task/core/api/Endpoints.dart';
import 'package:elevate_ecommerce_task/models/rating_model.dart';

class ProductModel {
  final int? id;
  final String? title;
  final num? price;
  final String? description;
  final String? image;
  final Rating? rating;

  ProductModel({
    this.id,
     this.title,
     this.image,
     this.description,
     this.price,
     this.rating,
  });

  String get formattedPrice => price?.toStringAsFixed(2) ?? "0.0";
  String get formattedOldPrice => oldPrice?.toStringAsFixed(2) ?? "0.0";
  String get formattedRating => rating?.rate?.toStringAsFixed(1) ?? "0.0";

  num get oldPrice => (price ?? 0) * 1.35;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json[JsonKey.id],
    title: json[JsonKey.title],
    image: json[JsonKey.image],
    price:(json[JsonKey.price] as num?)?.toDouble() ,
    description: json[JsonKey.description],
    rating: json[JsonKey.rating] != null ? Rating.fromJson(json[JsonKey.rating]) : null,
  );
}
