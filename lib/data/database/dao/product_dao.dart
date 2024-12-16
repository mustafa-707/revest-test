import 'package:drift/drift.dart';
import 'package:revest/data/database/db.dart';
import 'package:revest/data/database/schema/product_schema.dart';

part '../../../generated/data/database/dao/product_dao.g.dart';

@DriftAccessor(tables: [Products, Categories, ProductImages])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  final AppDatabase db;

  ProductDao(this.db) : super(db);

  Future<int> insertProduct(ProductsCompanion product) async {
    return into(products).insert(
      product,
      mode: InsertMode.replace,
    );
  }

  Future<void> insertProducts(List<ProductsCompanion> productList) async {
    await batch((batch) {
      batch.insertAll(
        products,
        productList,
        mode: InsertMode.replace,
      );
    });
  }

  Future<List<Product>> getAllProducts() async {
    return select(products).get();
  }

  Stream<List<Product>> watchAllProducts() {
    return select(products).watch();
  }

  Future<Product?> getProductById(int id) async {
    return (select(products)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> upsertCategories(List<CategoriesCompanion> categoriesList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(categories, categoriesList);
    });
  }

  Future<int> deleteProduct(int id) async {
    return (delete(products)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateProduct(Product product) async {
    return update(products).replace(product);
  }

  Future<void> insertProductImages(List<ProductImagesCompanion> images) async {
    await batch((batch) {
      batch.insertAll(
        productImages,
        images,
        mode: InsertMode.replace,
      );
    });
  }

  Future<List<ProductImage>> getImagesForProduct(int productId) async {
    return await (select(productImages)..where((tbl) => tbl.productId.equals(productId))).get();
  }
}
