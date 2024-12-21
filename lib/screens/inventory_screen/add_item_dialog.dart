import 'package:flutter/material.dart';
import 'package:pos_flutter/blocs/inventory/inventory_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemDialog extends StatelessWidget {
  const AddItemDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController skuController = TextEditingController();

    return AlertDialog(
      title: const Text("Add New Item"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            keyboardType: TextInputType.text,
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: true),
          ),
          TextField(
            controller: quantityController,
            decoration: const InputDecoration(labelText: 'Stock Quantity'),
            keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: false),
          ),
          TextField(
            controller: skuController,
            decoration: const InputDecoration(labelText: 'SKU'),
            keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: false),
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
            final String name = nameController.text.trim();
            final String description = descriptionController.text.trim();
            final double price =
                double.tryParse(priceController.text.trim()) ?? 0.0;
            final int quantity =
                int.tryParse(quantityController.text.trim()) ?? 0;
            final String sku = skuController.text.trim();

            if (name.isNotEmpty && quantity > -1) {
              context.read<InventoryBloc>().add(
                    AddInventoryItem(
                      product_id: 0,
                      name: name,
                      description: description,
                      price: price,
                      stock: quantity,
                      sku: sku,
                      artwork_id: 0,
                    ),
                  );
              Navigator.pop(context); // Close the dialog
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter valid details")),
              );
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
