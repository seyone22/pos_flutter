import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/blocs/inventory/inventory_bloc.dart';
import 'package:pos_flutter/data/database.dart';
import 'package:pos_flutter/screens/inventory_screen/add_item_dialog.dart';
import 'package:pos_flutter/screens/inventory_screen/delete_confirmation_dialog.dart';
import 'package:pos_flutter/screens/inventory_screen/edit_item_dialog.dart';
import 'package:flutter/scheduler.dart';
import 'package:pos_flutter/screens/inventory_screen/restock_item_dialog.dart';
import 'package:pos_flutter/widgets/generic_search_bar.dart';
import 'adjust_item_dialog.dart';
import 'inventory_list.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey menuKey = GlobalKey();

  String _searchQuery = '';
  List<ProductData> _filteredItems = [];
  Map<int, int> _sales = {};

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Dispatch an event to load inventory data when the screen is loaded
    context.read<InventoryBloc>().add(LoadInventory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          if (state is InventoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InventoryError) {
            // Schedule the Snackbar to be shown after the current build frame
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error: ${state.message}"),
                  backgroundColor:
                      Colors.red, // Customize the background color for errors
                  duration:
                      const Duration(seconds: 3), // Duration for the Snackbar
                ),
              );
            });
          }

          if (state is InventoryLoaded) {
            _filteredItems = state.items.where((item) {
              final query = _searchQuery.toLowerCase();
              return item.name.toLowerCase().contains(query) ||
                  item.description.toLowerCase().contains(query) ||
                  item.sku.toLowerCase().contains(query);
            }).toList();
            _sales = state.sales;

            return Container(
              margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GenericSearchBar(
                    hintText: 'Search items',
                    focusNode: _searchFocusNode,
                    trailing: [
                      MenuAnchor(
                        key: menuKey,
                        builder: (context, controller, child) {
                          return IconButton(
                            icon: const Icon(Icons.more_vert),
                            tooltip: 'More settings',
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                          );
                        },
                        menuChildren: [
                          MenuItemButton(
                            onPressed: () => _showAddItemDialog(context),
                            child: const Text('Add Item'),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              context.read<InventoryBloc>().add(ImportInventory());
                            },
                            child: const Text('Import Inventory'),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              context.read<InventoryBloc>().add(ExportInventory());
                            },
                            child: const Text('Export Inventory'),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              context.read<InventoryBloc>().add(ExportInventoryReconciliation());
                            },
                            child: const Text('Export for Inventory Reconciliation'),
                          ),
                        ],
                      ),
                    ],
                    onSearchChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                        final items = (state).items;
                        _filteredItems = items.where((item) {
                          final lowerQuery = _searchQuery.toLowerCase();
                          return item.name.toLowerCase().contains(lowerQuery) ||
                              item.description
                                  .toLowerCase()
                                  .contains(lowerQuery) ||
                              item.sku.toLowerCase().contains(lowerQuery);
                        }).toList();
                      });
                    },
                  ),
                  const SizedBox(
                      height: 16), // Spacing between buttons and table
                  // Data Table
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InventoryListWidget(
                      filteredItems: _filteredItems,
                      onSingleTap: _showContextMenu,
                      sales: _sales,
                    ),
                  ))
                ],
              ),
            );
          }
          return const Center(child: Text("No inventory data"));
        },
      ),
    );
  }

  // Function to show the context menu
  void _showContextMenu(BuildContext context, int index, ProductData item) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final relative = overlay.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(relative.dx, relative.dy, 0.0, 0.0),
      items: [
        PopupMenuItem<String>(
          value: 'edit',
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _showEditItemDialog(context, index, item);
            },
          ),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context); // Close the context menu
              _showDeleteConfirmationDialog(
                  context, index, item.id); // Show confirmation dialog
            },
          ),
        ),
        PopupMenuItem<String>(
          value: 'restock',
          child: ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text('Restock'),
            onTap: () {
              Navigator.pop(context); // Close the context menu
              _showRestockItemDialog(
                  context, index, item.id, item.sku); // Show confirmation dialog
            },
          ),
        ),
        PopupMenuItem<String>(
          value: 'restock',
          child: ListTile(
            leading: const Icon(Icons.adjust),
            title: const Text('Adjust stock'),
            onTap: () {
              Navigator.pop(context); // Close the context menu
              _showAdjustItemDialog(
                  context, index, item.id, item.sku); // Show confirmation dialog
            },
          ),
        ),
      ],
    );
  }

  // Function to show the Add Item dialog
  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddItemDialog();
      },
    );
  }

  void _showEditItemDialog(BuildContext context, int index, ProductData item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditItemDialog(
          productId: item.id,
          currentName: item.name,
          currentDescription: item.description,
          currentPrice: item.price,
          currentStock: item.stock,
          currentSku: item.sku,
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int index, int productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(productId: productId);
      },
    );
  }

  void _showRestockItemDialog(BuildContext context, int index, int productId, String sku) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RestockItemDialog(
          productId: productId, sku: sku,
        );
      },
    );
  }

  void _showAdjustItemDialog(BuildContext context, int index, int productId, String sku) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AdjustItemDialog(
          productId: productId, sku: sku,
        );
      },
    );
  }
}
