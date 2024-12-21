import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/invoice/invoice_bloc.dart';
import './total_row.dart';
import 'package:intl/intl.dart';

import 'customer_details_dialog.dart';
import 'discount_row.dart';

class InvoiceSummary extends StatelessWidget {
  final InvoiceState invoiceState;
  final bool isPercentageDiscount;
  final double discount;
  final double tendered;
  final Function(bool) onDiscountChanged;
  final Function(double) onTenderedChanged;

  const InvoiceSummary({
    super.key,
    required this.invoiceState,
    required this.isPercentageDiscount,
    required this.discount,
    required this.tendered,
    required this.onDiscountChanged,
    required this.onTenderedChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Use type checking to ensure invoiceState is InvoiceLoaded before accessing invoiceProducts
    if (invoiceState is! InvoiceLoaded && invoiceState is! InvoiceUpdated) {
      return const Center(child: Text('No invoice data'));
    }

    final invoiceLoadedState = invoiceState as InvoiceUpdated;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Invoice Items'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: invoiceLoadedState.invoiceProducts.length,
              itemBuilder: (context, index) {
                final item = invoiceLoadedState.invoiceProducts[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => context
                              .read<InvoiceBloc>()
                              .add(DeleteFromInvoice(item.product_id)),
                          icon: const Icon(Icons.delete_outline)),
                      Text(item.product_id.toString()),
                      IconButton(
                          onPressed: () => context
                              .read<InvoiceBloc>()
                              .add(RemoveFromInvoice(item.product_id)),
                          icon: const Icon(Icons.remove)),
                      Text('${item.quantity}'),
                      IconButton(
                          onPressed: () => context
                              .read<InvoiceBloc>()
                              .add(AddToInvoice(item.product_id, item.price)),
                          icon: const Icon(Icons.add)),
                      Text(
                          NumberFormat.currency(locale: 'en_IN', symbol: 'Rs. ')
                              .format(item.price * item.quantity)),
                    ],
                  ),
                );
              },
            ),
            DiscountRow(
              isPercentageDiscount: isPercentageDiscount,
              discount: discount,
              onDiscountChanged: onDiscountChanged,
            ),
            TotalRow(
              invoiceState: invoiceState,
              isPercentageDiscount: isPercentageDiscount,
              discount: discount,
            ),
            TenderedAmountRow(
                tendered: tendered, onTenderedChanged: onTenderedChanged),
          ],
        ),
      ),
    );
  }
}
