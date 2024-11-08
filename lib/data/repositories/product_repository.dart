
import '../database.dart';

class ProductRepository {
  final AppDatabase db;

  ProductRepository({required this.db});

  // Get all items in the inventory
  Future<List<products>> getAllProductItems() {
    return db.getAllProductItems();
  }

  // Add an item to inventory
  Future<void> addProductItem(String productId, int quantity) {
    return db.addProductItem(productId, quantity);
  }

  // Reduce quantity or remove an item from the inventory
  Future<void> removeProductItem(int productId, int stock) async {
    final item = await (db.select(db.product)
          ..where((tbl) => tbl.id.equals(productId)))
        .getSingle();
    if (item != null && item.stock >= stock) {
      final newQuantity = item.stock - stock;
      if (newQuantity > 0) {
        await db.updateProductItemQuantity(productId, newQuantity);
      } else {
        await db.removeProductItem(productId);
      }
    }
  }
}
