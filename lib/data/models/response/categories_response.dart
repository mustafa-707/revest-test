import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/data/models/response/categories_response.freezed.dart';
part '../../../generated/data/models/response/categories_response.g.dart';

@freezed
class CategoriesResponse with _$CategoriesResponse {
  const factory CategoriesResponse({
    required List<String> categories,
  }) = _CategoriesResponse;

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => _$CategoriesResponseFromJson(json);
}
