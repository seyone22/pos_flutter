import 'package:flutter/material.dart';
import 'package:pos_flutter/blocs/inventory/inventory_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditItemDialog extends StatelessWidget {
  final int productId;
  final String currentName;
  final String currentDescription;
  final double currentPrice;
  final int currentStock;
  final String currentSku;

  const EditItemDialog({
    super.key,
    required this.productId,
    required this.currentName,
    required this.currentDescription,
    required this.currentPrice,
    required this.currentStock,
    required this.currentSku,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: currentName);
    final TextEditingController descriptionController = TextEditingController(text: currentDescription);
    final TextEditingController priceController = TextEditingController(text: currentPrice.toString());
    final TextEditingController stockController = TextEditingController(text: currentStock.toString());
    final TextEditingController skuController = TextEditingController(text: currentSku);

    return AlertDialog(
      title: const Text("Edit Item"),
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
            controller: stockController,
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
            final int stock =
                int.tryParse(stockController.text.trim()) ?? 0;
            final String sku = skuController.text.trim();

            if (name.isNotEmpty && stock >= 0) {
              context.read<InventoryBloc>().add(
                    EditInventoryItem(
                      product_id: productId,
                      name: name,
                      description: description,
                      price: price,
                      stock: stock,
                      sku: sku,
                      artwork_id: 0, // Adjust as needed
                    ),
                  );
              Navigator.pop(context); // Close the dialog
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter valid details")),
              );
            }
          },
          child: const Text("Save Changes"),
        ),
      ],
    );
  }
}
