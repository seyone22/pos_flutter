import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/blocs/inventory/inventory_bloc.dart';

class RestockItemDialog extends StatefulWidget {
  final int productId;
  final String sku;

  const RestockItemDialog({
    super.key,
    required this.productId,
    required this.sku,
  });

  @override
  State<RestockItemDialog> createState() => _RestockItemDialogState();
}

class _RestockItemDialogState extends State<RestockItemDialog> {
  final TextEditingController newStockAmountController = TextEditingController();
  String? selectedSupplier;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Restock - ${widget.sku}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: newStockAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Additional stock quantity'),
          ),
          DropdownButtonFormField<String>(
            value: selectedSupplier,
            decoration: const InputDecoration(labelText: 'Supplier'),
            items: const [
              DropdownMenuItem(value: 'Anim8', child: Text('Anim8')),
              DropdownMenuItem(value: 'SoftWave', child: Text('SoftWave')),
              DropdownMenuItem(value: 'Others', child: Text('Others')),
            ],
            onChanged: (value) {
              setState(() {
                selectedSupplier = value;
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
            final int newStockAmount = int.tryParse(newStockAmountController.text.trim()) ?? 0;

            if (newStockAmount > 0 && selectedSupplier != null) {
              context.read<InventoryBloc>().add(
                RestockInventoryItem(
                  productId: widget.productId,
                  newStockAmount: newStockAmount,
                  supplierId: _getSupplierId(selectedSupplier!),
                ),
              );
              Navigator.pop(context); // Close the dialog
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter valid details")),
              );
            }
          },
          child: const Text("Restock Item"),
        ),
      ],
    );
  }

  int _getSupplierId(String supplier) {
    switch (supplier) {
      case 'Anim8':
        return 1;
      case 'SoftWave':
        return 2;
      case 'Others':
        return 3;
      default:
        return 0;
    }
  }

  @override
  void dispose() {
    newStockAmountController.dispose();
    super.dispose();
  }
}
