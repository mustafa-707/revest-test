import 'package:drift/drift.dart';

// Table for the "products"
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  RealColumn get price => real()();
  RealColumn get discountPercentage => real()();
  RealColumn get rating => real()();
  IntColumn get stock => integer()();
  TextColumn get brand => text()();
  TextColumn get thumbnail => text().nullable()();
}

// Table for "categories"
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

// Table for "product images"
class ProductImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  TextColumn get imageUrl => text()();
}
