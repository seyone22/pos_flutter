import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

@DataClassName('products')
class Product extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name =>  text().withLength(min: 0, max: 32)();
  RealColumn get price => real()();
  IntColumn get stock => integer().check(stock.isBiggerThanValue(-1))();
  TextColumn get description => text()();
}

@DataClassName('invoices')
class Invoice extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customer_id => integer().check(customer_id.isNotNull())();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get subtotal => real()();
  TextColumn get discount_type => text()();
  RealColumn get discount_amount => real()();
  RealColumn get tendered => real()();
  TextColumn get currency => text().withLength(min:3, max: 3)();
  TextColumn get payment_method => text().withLength(min: 4, max: 4)();
  TextColumn get status => text()();
  TextColumn get goods_status => text()();
}

@DataClassName('invoice_products')
class InvoiceProduct extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoice_id => integer().check(invoice_id.isNotNull())();
  IntColumn get product_id => integer().check(product_id.isNotNull())();
  IntColumn get quantity => integer()();
  RealColumn get price => real()();
}

@DataClassName('restocks')
class Restock extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get product_id => integer().check(product_id.isNotNull())();
  IntColumn get supplier_id => integer().check(supplier_id.isNotNull())();
  IntColumn get quantity => integer()();
  DateTimeColumn get timestamp => dateTime()();
}

@DataClassName('customers')
class Customer extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get phone_number => text()();
  TextColumn get address => text()();
}

@DataClassName('suppliers')
class Supplier extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

@DataClassName('inventory_adjustments')
class InventoryAdjustment extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get product_id => integer().check(product_id.isNotNull())();
  TextColumn get type => text()();
  IntColumn get quantity => integer()();
  DateTimeColumn get timestamp => dateTime()();
}

@DataClassName('product_variants')
class ProductVariant extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get product_id => integer().check(product_id.isNotNull())();
  TextColumn get variant_type => text()();
  TextColumn get name => text()();
  RealColumn get price_adjustment => real()();
}

@DataClassName('audit_logs')
class AuditLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get action_type => text()();
  TextColumn get user => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get description => text()();
}


// Drift database class
@DriftDatabase(tables: [Product, Invoice, InvoiceProduct, Restock, Customer, Supplier, InventoryAdjustment, ProductVariant, AuditLog])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Queries for products
  Future<List<products>> getAllProductItems() => select(product).get();
  
  Future<void> addProductItem(String name, int quantity) {
    return into(product).insert(
      ProductCompanion(
        name: Value(name),
        stock: Value(quantity),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> updateProductItemQuantity(int productId, int newQuantity) {
    return (update(product)
          ..where((tbl) => tbl.id.equals(productId)))
        .write(ProductCompanion(stock: Value(newQuantity)));
  }

  Future<void> removeProductItem(int productId) {
    return (delete(product)..where((tbl) => tbl.id.equals(productId))).go();
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'pos_db');
  }
}