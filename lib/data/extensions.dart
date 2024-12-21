import 'package:pos_flutter/data/database.dart';

extension InvoiceProductCopyWith on InvoiceProductData {
  InvoiceProductData copyWith({
    int? id,
    int? invoice_id,
    int? product_id,
    int? quantity,
    double? price,
  }) {
    return InvoiceProductData(
      id: id ?? this.id,
      invoice_id: invoice_id ?? this.invoice_id,
      product_id: product_id ?? this.product_id,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
