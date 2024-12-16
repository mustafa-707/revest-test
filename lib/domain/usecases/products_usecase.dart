import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:revest/data/database/db.dart';
import 'package:revest/data/models/product_model.dart';
import 'package:revest/domain/repository/products_repository.dart';
import 'package:revest/data/database/dao/product_dao.dart';

class ProductsUseCase {
  final ProductDao productDao;
  final ProductsRepository productApi;

  ProductsUseCase({
    required this.productDao,
    required this.productApi,
  });

  Future<int> fetchAndSave(int index) async {
    try {
      final products = await productApi.getAllProducts(index);
      final productCompanions = products.products
          .map(
            (p) => {
              'productCompanion': ProductsCompanion(
                id: Value(p.id),
                title: Value(p.title),
                description: Value(p.description),
                category: Value(p.category ?? ''),
                price: Value(p.price),
                discountPercentage: Value(p.discountPercentage),
                rating: Value(p.rating),
                stock: Value(p.stock),
                brand: Value(p.brand ?? ''),
                thumbnail: Value(p.thumbnail),
              ),
              'imageCompanions': p.images
                  .map(
                    (imageUrl) => ProductImagesCompanion(
                      productId: Value(p.id),
                      imageUrl: Value(imageUrl),
                    ),
                  )
                  .toList(),
            },
          )
          .toList();

      await Future.forEach(productCompanions, (item) async {
        await productDao.insertProduct(item['productCompanion'] as ProductsCompanion);
        await productDao.insertProductImages(item['imageCompanions'] as List<ProductImagesCompanion>);
      });

      log('Successfully inserted products and their images.');
      return products.products.length;
    } catch (e) {
      log('Error fetching and saving products: $e');
      rethrow;
    }
  }

  Future<ProductModel> getProductById(int id) {
    return productApi.getProductsById(id);
  }
}
