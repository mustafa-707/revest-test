import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revest/data/models/product_model.dart';
import 'package:revest/data/services/apis/products.dart';
import 'package:revest/data/services/http.api.dart';
import 'package:revest/domain/usecases/products_usecase.dart';
import 'package:revest/provider/db.dart';
import 'package:revest/provider/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final productProvider = FutureProvider.family<ProductModel, int>((ref, productId) async {
  final productController = ref.read(productControllerProvider.notifier);
  return await productController.getProductById(productId);
});

class ProductControllerState {
  final List<ProductModel> products;
  final bool isLoading;
  final String errorMessage;

  ProductControllerState({
    required this.products,
    required this.isLoading,
    required this.errorMessage,
  });

  ProductControllerState.initial()
      : products = [],
        isLoading = false,
        errorMessage = '';

  ProductControllerState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductControllerState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final productsAPIProvider = Provider<ProductsAPIService>((ref) {
  final backendService = ref.read(backendProvider);
  return ProductsAPIService(backend: backendService);
});

final productControllerProvider = StateNotifierProvider<ProductController, ProductControllerState>((ref) {
  final sharedPrefs = ref.watch(sharedPrefsProvider);
  assert(
    sharedPrefs != null,
    "App settings must not be used before SharedPreferences are initialized!",
  );
  final productDao = ref.watch(productDaoProvider);
  final productApi = ref.watch(productsAPIProvider);

  final productUseCase = ProductsUseCase(
    productDao: productDao,
    productApi: productApi,
  );
  return ProductController(
    productUseCase,
    sharedPrefs!,
  );
});

class ProductController extends StateNotifier<ProductControllerState> {
  final ProductsUseCase productsUseCase;
  final SharedPreferences prefs;

  ProductController(this.productsUseCase, this.prefs) : super(ProductControllerState.initial()) {
    _fetchAndSaveProducts();
  }

  Future<void> _fetchAndSaveProducts() async {
    int currentIndex = prefs.getInt(PrefKeys.currentPageIndex) ?? 0;

    try {
      bool hasMore = true;
      final limit = ProductsAPIService.limit;
      while (hasMore) {
        final fetchedProductsCount = await productsUseCase.fetchAndSave(currentIndex);
        log('products :: fetch and save: Page $currentIndex, Limit: $fetchedProductsCount/$limit');

        if (fetchedProductsCount < limit) {
          log('Reached the last page at index: $currentIndex');
          hasMore = false;
        } else {
          currentIndex += limit;
          await prefs.setInt(PrefKeys.currentPageIndex, currentIndex);
        }
      }
    } catch (e) {
      log('Error during fetch and save: $e');
    }
  }

  Stream<List<ProductModel>> getProductsStream() {
    return productsUseCase.productDao.watchAllProducts().asyncMap((products) async {
      final productModels = await Future.wait(products.map((product) async {
        final images = await productsUseCase.productDao.getImagesForProduct(product.id);

        return ProductModel.productToProductModel(product, images);
      }));
      return productModels;
    });
  }

  Future<ProductModel> getProductById(int id) async {
    final product = await productsUseCase.productDao.getProductById(id);
    final images = await productsUseCase.productDao.getImagesForProduct(id);
    if (product != null) {
      return ProductModel(
        id: product.id,
        title: product.title,
        description: product.description,
        price: product.price,
        discountPercentage: product.discountPercentage,
        rating: product.rating,
        stock: product.stock,
        images: images.map((i) => i.imageUrl).toList(),
        brand: product.brand,
        category: product.category,
        thumbnail: product.thumbnail,
      );
    } else {
      return productsUseCase.getProductById(id);
    }
  }
}

final productsStreamProvider = StreamProvider<List<ProductModel>>((ref) {
  final productController = ref.watch(productControllerProvider.notifier);

  return productController.getProductsStream();
});
