import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:revest/data/database/dao/product_dao.dart';
import 'package:revest/data/database/schema/product_schema.dart';

part '../../generated/data/database/db.g.dart';

@DriftDatabase(tables: [Products, Categories, ProductImages], daos: [ProductDao])
class AppDatabase extends _$AppDatabase {
  // Specify the schema version
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

// This method opens a connection to the database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(
      p.join(dbFolder.path, 'app_database.sqlite'),
    );
    return NativeDatabase(file);
  });
}
