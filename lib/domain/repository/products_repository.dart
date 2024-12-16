import 'package:revest/data/models/product_model.dart';
import 'package:revest/data/models/response/product_response.dart';

abstract class ProductsRepository {
  Future<ProductResponse> getAllProducts(int page);
  Future<ProductResponse> getProductsByCategory(String category);
  Future<ProductModel> getProductsById(int id);
}
