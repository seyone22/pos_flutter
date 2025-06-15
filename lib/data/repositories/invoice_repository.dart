import '../database.dart';
import 'package:drift/drift.dart';

class InvoiceRepository {
  final AppDatabase db;

  InvoiceRepository({required this.db});

  // Get all items in the inventory
  Future<List<InvoiceData>> getAllInvoiceItems() {
    return db.getAllInvoiceItems();
  }

  // Add an item to inventory
  Future<void> addProductItem(int productId, String name, String description,
      double price, int stock, String sku, int artworkId) {
    return db.addProductItem(
        productId,
        name,
        description,
        price,
        stock,
        sku,
        artworkId);
  }

  Future<void> removeProductItem(int productId) async {
    // Delete the product item directly from the database using its ID
    await db.removeProductItem(productId);
  }

  // Example function to update a product item in the database
  Future<void> updateProductItem(int productId, String name, String description,
      double price, int stock, String sku, int artworkId) async {
    await db.updateProductItem(
        productId,
        name,
        description,
        price,
        stock,
        sku,
        artworkId);
  }

  Future<void> submitInvoice(InvoiceData invoiceData,
      List<InvoiceProductData> invoiceProducts, CustomerData customer) async {
    // Start a transaction to ensure the invoice is processed atomically
    await db.transaction(() async {
      // Step 0: Check if customer exists (by name), if not add new one
      int customerId;

      final existingCustomer = await (db.select(db.customer)
        ..where((tbl) => tbl.name.equals(customer.name)))
          .getSingleOrNull();

      if (existingCustomer != null) {
        // Customer exists, use their id
        customerId = existingCustomer.id;
      } else {
        // Customer doesn't exist, add a new one
        final newCustomerId = await db.into(db.customer).insert(
            CustomerCompanion(
                address: Value(customer.address),
                name: Value(customer.name),
                email: Value(customer.email),
                phone_number: Value(customer.phone_number)));
        customerId = newCustomerId;
      }

      // Step 1: Insert the invoice into the invoices table
      final i = InvoiceCompanion(
        customer_id: Value(invoiceData.customer_id),
        timestamp: Value(invoiceData.timestamp),
        subtotal: Value(invoiceData.subtotal),
        total: Value(invoiceData.total),
        discount_type: Value(invoiceData.discount_type),
        discount_amount: Value(invoiceData.discount_amount),
        tendered: Value(invoiceData.tendered),
        currency: Value(invoiceData.currency),
        payment_method: Value(invoiceData.payment_method),
        status: Value(invoiceData.status),
        goods_status: Value(invoiceData.goods_status),
      );

      final invoiceId = await db.into(db.invoice).insert(i);

      // Step 2: Deduct the relevant quantity of items from the products table
      for (var invoiceProduct in invoiceProducts) {
        final product = await (db.select(db.product)
          ..where((tbl) => tbl.id.equals(invoiceProduct.product_id)))
            .getSingle();
        final newStock = product.stock - invoiceProduct.quantity;

        // Update the product's stock
        await (db.update(db.product)
          ..where((tbl) => tbl.id.equals(invoiceProduct.product_id)))
            .write(ProductCompanion(stock: Value(newStock)));

        // Step 3: Add the invoice_product item with the correct invoice id and product details
        await db.into(db.invoiceProduct).insert(InvoiceProductCompanion(
          invoice_id: Value(invoiceId),
          product_id: Value(invoiceProduct.product_id),
          quantity: Value(invoiceProduct.quantity),
          price: Value(invoiceProduct.price),
        ));
      }
    });
  }

  Future<List<InvoiceData>> getAllInvoices() async {
    final invoices = await (db.select(db.invoice)).get();
    return invoices;
  }

  Future<InvoiceData> getInvoiceById(int invoiceId) async {
    final invoice = await (db.select(db.invoice)
      ..where((tbl) => tbl.id.equals(invoiceId)))
        .getSingle();
    return invoice;
  }

  Future<List<InvoiceData>> getInvoicesByDateRange(DateTime startDate,
      DateTime endDate) async {
    // Ensure the startDate is the beginning of the day (00:00:00) and endDate is the end of the day (23:59:59)
    final startOfDay = DateTime(startDate.year, startDate.month, startDate.day);
    final endOfDay =
    DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    final invoices = await (db.select(db.invoice)
      ..where((tbl) => tbl.timestamp.isBetweenValues(startOfDay, endOfDay)))
        .get();

    return invoices;
  }

  Future<List<InvoiceProductData>> getInvoiceProductsForInvoice(
      int invoiceId) async {
    final invoiceProducts = await (db.select(db.invoiceProduct)
      ..where((tbl) => tbl.invoice_id.equals(invoiceId)))
        .get();

    return invoiceProducts;
  }

  Future<List<ProductData>> getProductsForInvoice(int invoiceId) async {
    final invoiceProducts = await getInvoiceProductsForInvoice(invoiceId);
    final products = <ProductData>[];

    for (var invoiceProduct in invoiceProducts) {
      final product = await (db.select(db.product)
        ..where((tbl) => tbl.id.equals(invoiceProduct.product_id)))
          .getSingleOrNull();
      if (product != null) {
        products.add(product);
      }
    }
    return products;
  }
}



