import 'package:flutter/material.dart';
import 'package:pos_flutter/blocs/inventory/inventory_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final int productId;

  const DeleteConfirmationDialog({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Item"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // Dispatch event to delete the item
            context.read<InventoryBloc>().add(RemoveInventoryItem(product_id: productId));
            Navigator.pop(context); // Close the dialog after deletion
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
