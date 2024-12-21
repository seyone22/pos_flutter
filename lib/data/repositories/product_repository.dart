import 'package:drift/drift.dart';

import '../database.dart';

class ProductRepository {
  final AppDatabase db;

  ProductRepository({required this.db});

  // Get all items in the inventory
  Future<List<ProductData>> getAllProductItems() {
    return db.getAllProductItems();
  }

  // Get all items in the inventory
  Future<ProductData> getProductById(int productId) async {
    final product = await (db.select(db.product)
          ..where((tbl) => tbl.id.equals(productId)))
        .getSingle();
    return product;
  }

  Future<Map<int, int>> getSalesForAllProducts() async {
    final sales = await (db.select(db.invoiceProduct).get());

    // Map to hold entries
    final Map<int, int> productSales = {};

    for (var entry in sales) {
      final productId = entry.product_id;
      final quantity = entry.quantity;

      if (productSales.containsKey(productId)) {
        productSales[productId] = productSales[productId]! + quantity;
      } else {
        productSales[productId] = quantity;
      }
    }

    return productSales;
  }

  // Add an item to inventory
  Future<void> addProductItem(int productId, String name, String description,
      double price, int stock, String sku, int artworkId) {
    return db.addProductItem(
        productId, name, description, price, stock, sku, artworkId);
  }

  Future<void> restockProduct(
      int productId, int newStockAmount, int supplierId) async {
    final restock = await (db.into(db.restock).insert(RestockCompanion(
        product_id: Value(productId),
        supplier_id: Value(supplierId),
        quantity: Value(newStockAmount),
        timestamp: Value(DateTime.now()))));

    // Get the current stock value
    final product = await (db.select(db.product)
          ..where((tbl) => tbl.id.equals(productId)))
        .getSingleOrNull();

    if (product != null) {
      final updatedStock = product.stock + newStockAmount;

      // Update the product's stock
      await (db.update(db.product)..where((tbl) => tbl.id.equals(productId)))
          .write(ProductCompanion(
        stock: Value(updatedStock),
      ));
    }
  }

  Future<void> adjustProduct(
      int productId, int adjustmentAmount, String type) async {
    final adjustment = await (db.into(db.inventoryAdjustment).insert(InventoryAdjustmentCompanion(
        product_id: Value(productId),
        type: Value(type),
        quantity: Value(adjustmentAmount),
        timestamp: Value(DateTime.now()))));

    // Get the current stock value
    final product = await (db.select(db.product)
      ..where((tbl) => tbl.id.equals(productId)))
        .getSingleOrNull();

    if (product != null) {
      final updatedStock = product.stock + adjustmentAmount;

      // Update the product's stock
      await (db.update(db.product)..where((tbl) => tbl.id.equals(productId)))
          .write(ProductCompanion(
        stock: Value(updatedStock),
      ));
    }
  }

  Future<void> removeProductItem(int productId) async {
    // Delete the product item directly from the database using its ID
    await db.removeProductItem(productId);
  }

  // Example function to update a product item in the database
  Future<void> updateProductItem(int productId, String name, String description,
      double price, int stock, String sku, int artworkId) async {
    await db.updateProductItem(
        productId, name, description, price, stock, sku, artworkId);
  }
}
