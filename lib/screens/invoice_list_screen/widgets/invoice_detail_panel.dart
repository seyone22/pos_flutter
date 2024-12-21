import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter/data/database.dart';

class InvoiceDetailsPanel extends StatelessWidget {
  final InvoiceData? selectedInvoice;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const InvoiceDetailsPanel({
    super.key,
    this.selectedInvoice,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedInvoice == null) {
      return Center(
        child: Text(
          "No Invoice Selected",
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Invoice #${selectedInvoice!.id}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              _buildDetailRow(
                  "Customer ID:", selectedInvoice!.customer_id.toString()),
              _buildDetailRow(
                  "Payment Method:", selectedInvoice!.payment_method),
              _buildDetailRow(
                "Subtotal:",
                NumberFormat.currency(locale: 'en_IN', symbol: 'Rs.')
                    .format(selectedInvoice!.subtotal),
              ),
              _buildDetailRow(
                "Discount:",
                NumberFormat.currency(locale: 'en_IN', symbol: 'Rs.')
                    .format(selectedInvoice!.discount_amount),
              ),
              _buildDetailRow(
                "Total Amount:",
                NumberFormat.currency(locale: 'en_IN', symbol: 'Rs.')
                    .format(selectedInvoice!.total),
              ),
              _buildDetailRow(
                "Tendered:",
                NumberFormat.currency(locale: 'en_IN', symbol: 'Rs.')
                    .format(selectedInvoice!.tendered),
              ),
            ],
          ),
        ));
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
