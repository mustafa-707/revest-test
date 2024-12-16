import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revest/data/database/dao/product_dao.dart';
import 'package:revest/data/database/db.dart';

final databaseProvider = StateProvider<AppDatabase?>((ref) => null);

final productDaoProvider = Provider<ProductDao>((ref) {
  final database = ref.watch(databaseProvider);
  return ProductDao(database!);
});
