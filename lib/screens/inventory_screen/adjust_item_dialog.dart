import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/blocs/inventory/inventory_bloc.dart';

class AdjustItemDialog extends StatefulWidget {
  final int productId;
  final String sku;

  const AdjustItemDialog({
    super.key,
    required this.productId,
    required this.sku,
  });

  @override
  State<AdjustItemDialog> createState() => _AdjustItemDialogState();
}

class _AdjustItemDialogState extends State<AdjustItemDialog> {
  final TextEditingController adjustmentAmountController = TextEditingController();
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Stock Adjustment - ${widget.sku}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: adjustmentAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Adjustment value'),
          ),
          DropdownButtonFormField<String>(
            value: selectedType,
            decoration: const InputDecoration(labelText: 'Reason'),
            items: const [
              DropdownMenuItem(value: 'toArtist', child: Text('Returns to Artist')),
              DropdownMenuItem(value: 'damage', child: Text('Damaged Goods')),
              DropdownMenuItem(value: 'other', child: Text('Other')),
            ],
            onChanged: (value) {
              setState(() {
                selectedType = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            final int adjustmentAmount = int.tryParse(adjustmentAmountController.text.trim()) ?? 0;

            if (adjustmentAmount.isFinite && selectedType != null) {
              context.read<InventoryBloc>().add(
                AdjustInventoryItem(
                  productId: widget.productId,
                  adjustmentAmount: adjustmentAmount,
                  type: selectedType ?? 'other',
                ),
              );
              Navigator.pop(context); // Close the dialog
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter valid details")),
              );
            }
          },
          child: const Text("Adjust item stock"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    adjustmentAmountController.dispose();
    super.dispose();
  }
}
