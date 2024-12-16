import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revest/data/models/product_model.dart';

part '../../../generated/data/models/response/product_response.freezed.dart';
part '../../../generated/data/models/response/product_response.g.dart';

@freezed
class ProductResponse with _$ProductResponse {
  const factory ProductResponse({
    required List<ProductModel> products,
    required int total,
    required int skip,
    required int limit,
  }) = _ProductResponse;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);
}
