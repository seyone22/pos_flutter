import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';

part 'database.g.dart';

@DataClassName('ProductData')
class Product extends Table {
  @override
  String get tableName => 'products';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 0, max: 64)();
  TextColumn get description => text()();
  RealColumn get price => real()();
  IntColumn get stock => integer().check(stock.isBiggerThanValue(-1))();
  TextColumn get sku => text().withLength(min: 0, max: 32)();
  IntColumn get artworkId => integer().check(artworkId.isBiggerThanValue(-1))();
}

@DataClassName('InvoiceData')
class Invoice extends Table {
  @override
  String get tableName => 'invoices';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get customer_id => integer().check(customer_id.isNotNull())();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get subtotal => real()();
  RealColumn get total => real()();
  TextColumn get discount_type => text()();
  RealColumn get discount_amount => real()();
  RealColumn get tendered => real()();
  TextColumn get currency => text().withLength(min: 3, max: 3)();
  TextColumn get payment_method => text().withLength(min: 4, max: 4)();
  TextColumn get status => text()();
  TextColumn get goods_status => text()();
}

@DataClassName('InvoiceProductData')
class InvoiceProduct extends Table {
  @override
  String get tableName => "invoice_product";

  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoice_id => integer().check(invoice_id.isNotNull())();
  IntColumn get product_id => integer().check(product_id.isNotNull())();
  IntColumn get quantity => integer()();
  RealColumn get price => real()();
}

@DataClassName('RestockData')
class Restock extends Table {
  @override
  String get tableName => "restocks";

  IntColumn get id => integer().autoIncrement()();
  IntColumn get product_id => integer().check(product_id.isNotNull())();
  IntColumn get supplier_id => integer().check(supplier_id.isNotNull())();
  IntColumn get quantity => integer()();
  DateTimeColumn get timestamp => dateTime()();
}

@DataClassName('CustomerData')
class Customer extends Table {
  @override
  String get tableName => "customers";

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get phone_number => text()();
  TextColumn get address => text()();
}

@DataClassName('SupplierData')
class Supplier extends Table {
  @override
  String get tableName => "suppliers";

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

@DataClassName('InventoryAdjustmentData')
class InventoryAdjustment extends Table {
  @override
  String get tableName => "inventory_adjustments";

  IntColumn get id => integer().autoIncrement()();
  IntColumn get product_id => integer().check(product_id.isNotNull())();
  TextColumn get type => text()();
  IntColumn get quantity => integer()();
  DateTimeColumn get timestamp => dateTime()();
}

@DataClassName('ProductVariantData')
class ProductVariant extends Table {
  @override
  String get tableName => "product_variants";

  IntColumn get id => integer().autoIncrement()();
  IntColumn get product_id => integer().check(product_id.isNotNull())();
  TextColumn get variant_type => text()();
  TextColumn get name => text()();
  RealColumn get price_adjustment => real()();
}

@DataClassName('AuditLogData')
class AuditLog extends Table {
  @override
  String get tableName => "audit_logs";

  IntColumn get id => integer().autoIncrement()();
  TextColumn get action_type => text()();
  TextColumn get user => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get description => text()();
}

// Drift database class
@DriftDatabase(tables: [
  Product,
  Invoice,
  InvoiceProduct,
  Restock,
  Customer,
  Supplier,
  InventoryAdjustment,
  ProductVariant,
  AuditLog
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Queries for products
  Future<List<ProductData>> getAllProductItems() => select(product).get();

  Future<void> addProductItem(int productId, String name, String description,
      double price, int stock, String sku, int artworkId) {
    return into(product).insert(
      ProductCompanion(
          name: Value(name),
          description: Value(description),
          price: Value(price),
          stock: Value(stock),
          sku: Value(sku),
          artworkId: Value(artworkId)),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> updateProductItemQuantity(int productId, int newQuantity) {
    return (update(product)..where((tbl) => tbl.id.equals(productId)))
        .write(ProductCompanion(stock: Value(newQuantity)));
  }

  Future<void> removeProductItem(int productId) {
    return (delete(product)..where((tbl) => tbl.id.equals(productId))).go();
  }

  Future<void> updateProductItem(int productId, String name, String description,
      double price, int stock, String sku, int artworkId) {
    return (update(product)..where((tbl) => tbl.id.equals(productId))).write(
      ProductCompanion(
        name: Value(name),
        description: Value(description),
        price: Value(price),
        stock: Value(stock),
        sku: Value(sku),
        artworkId: Value(artworkId),
      ),
    );
  }

  // Queries for Customers
  Future<List<CustomerData>> getAllCustomers() => select(customer).get();

  // Queries for invoices
  Future<List<InvoiceData>> getAllInvoiceItems() => select(invoice).get();

  Future<void> addInvoiceItem(
      int customerId,
      DateTime timestamp,
      double subtotal,
      String discountType,
      double discountAmount,
      double tendered,
      String currency,
      String paymentMethod,
      String status,
      String goodsStatus) {
    return into(invoice).insert(
      InvoiceCompanion(
        customer_id: Value(customerId),
        timestamp: Value(timestamp),
        subtotal: Value(subtotal),
        discount_type: Value(discountType),
        discount_amount: Value(discountAmount),
        tendered: Value(tendered),
        currency: Value(currency),
        payment_method: Value(paymentMethod),
        status: Value(status),
        goods_status: Value(goodsStatus)
      ),
      mode: InsertMode.insertOrReplace,
    );
  }
}

LazyDatabase _openConnection() {
  /// the LazyDatabase util lets us find the right location
  /// for the file async.
  return LazyDatabase(() async {
    /// put the database file, called db.sqlite here, into the documents folder
    /// for your app.
    final dbFolder = await getApplicationDocumentsDirectory();

    /// You can replace [db.sqlite] with anything you want
    /// Ex: cat.sqlite, darthVader.sqlite, todoDB.sqlite
    final file = File(p.join(dbFolder.path, 'database.sqlite'));

    /// Make sqlite3 pick a more suitable location for temporary files - the
    /// one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;

    return NativeDatabase.createInBackground(file);
  });
}
