import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revest/data/database/db.dart';

part '../../generated/data/models/product_model.freezed.dart';
part '../../generated/data/models/product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    required String title,
    required String description,
    String? category,
    required double price,
    required double discountPercentage,
    required double rating,
    required int stock,
    String? brand,
    String? thumbnail,
    required List<String> images,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  static ProductModel productToProductModel(Product product, List<ProductImage> images) {
    return ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      category: product.category,
      price: product.price,
      discountPercentage: product.discountPercentage,
      rating: product.rating,
      stock: product.stock,
      brand: product.brand,
      thumbnail: product.thumbnail ?? '',
      images: images.map((image) => image.imageUrl).toList(),
    );
  }
}
