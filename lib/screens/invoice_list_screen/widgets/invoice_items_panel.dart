import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter/data/database.dart';

class InvoiceItemsPanel extends StatelessWidget {
  final List<InvoiceProductData>? invoiceProducts;
  final List<ProductData>? products;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const InvoiceItemsPanel({
    super.key,
    this.invoiceProducts,
    this.products,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (invoiceProducts == null || invoiceProducts!.isEmpty) {
      return Center(
        child: Text(
          "No products for this invoice!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.surfaceDim,
            ),
            columns: const [
              DataColumn(label: Text('SKU')),
              DataColumn(label: Text('Quantity'), numeric: true),
              DataColumn(label: Text('Price'), numeric: true),
            ],
            rows: invoiceProducts!.map((invoiceProduct) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      products!
                          .firstWhere(
                            (product) =>
                                product.id == invoiceProduct.product_id,
                            orElse: () => const ProductData(
                                id: -1,
                                name: 'Product not found',
                                description: '',
                                price: -1,
                                stock: -1,
                                sku: '',
                                artworkId: -1),
                          ).sku,
                    ),
                  ),
                  DataCell(Text(invoiceProduct.quantity.toString())),
                  DataCell(Text(
                    NumberFormat.currency(locale: 'en_IN', symbol: 'Rs.')
                        .format(invoiceProduct.price),
                  )),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
