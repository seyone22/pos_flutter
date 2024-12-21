import 'package:flutter/material.dart';
import '../../../blocs/invoice/invoice_bloc.dart';
import 'package:intl/intl.dart';

class TotalRow extends StatelessWidget {
  final InvoiceState invoiceState;
  final bool isPercentageDiscount;
  final double discount;

  const TotalRow({super.key, 
    required this.invoiceState,
    required this.isPercentageDiscount,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the state is of type InvoiceLoaded before accessing invoiceProducts
    double totalBeforeDiscount = 0.0;

    if (invoiceState is InvoiceLoaded) {
      totalBeforeDiscount = (invoiceState as InvoiceLoaded).invoiceProducts.fold(
        0.0,
            (total, item) => total + (item.price * item.quantity),
      );
    }

    final totalAfterDiscount = isPercentageDiscount
        ? totalBeforeDiscount * (1 - discount / 100)
        : totalBeforeDiscount - discount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Total (after discount):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Text(
          NumberFormat.currency(locale: 'en_IN', symbol: 'Rs').format(totalAfterDiscount),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
