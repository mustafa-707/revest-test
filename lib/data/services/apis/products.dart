import 'package:revest/data/models/product_model.dart';
import 'package:revest/data/models/response/product_response.dart';
import 'package:revest/data/services/endpoints.api.dart';
import 'package:revest/data/services/http.api.dart';
import 'package:revest/domain/repository/products_repository.dart';

class ProductsAPIService extends ProductsRepository {
  final BackendAPIService backend;
  static const limit = 20;
  ProductsAPIService({required this.backend});

  @override
  Future<ProductResponse> getAllProducts(int page) async {
    return backend.request(
      AppEndPoints.allProducts,
      method: RequestMethod.get,
      queryParams: {
        'limit': Uri.decodeComponent(limit.toString()),
        'skip': Uri.decodeComponent(page.toString()),
      },
      fromJson: ProductResponse.fromJson,
    );
  }

  @override
  Future<ProductResponse> getProductsByCategory(String category) {
    return backend.request(
      '${AppEndPoints.productByCategory}${Uri.decodeComponent(category.toString())}',
      method: RequestMethod.get,
      fromJson: ProductResponse.fromJson,
    );
  }

  @override
  Future<ProductModel> getProductsById(int id) {
    return backend.request(
      '${AppEndPoints.productById}${Uri.decodeComponent(id.toString())}',
      method: RequestMethod.get,
      fromJson: ProductModel.fromJson,
    );
  }
}
