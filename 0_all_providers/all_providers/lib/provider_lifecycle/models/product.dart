import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
  required final int id,
  required final String title,
  required final String description,
  required final String category,
  required final double price,
  required final double discountPercentage,
  required final double rating,
  required final int stock,
  @Default('') String brand,
  required final String thumbnail,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

}
