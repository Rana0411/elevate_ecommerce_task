import '../core/api/Endpoints.dart';

class Rating {
  final num? rate;

  Rating({ this.rate});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(

      rate: json[JsonKey.rate] != null ? (json[JsonKey.rate] as num).toDouble() : 0.0,
    );
  }
}