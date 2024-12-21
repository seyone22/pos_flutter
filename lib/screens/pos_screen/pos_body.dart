import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/blocs/inventory/inventory_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:pos_flutter/blocs/invoice/invoice_bloc.dart';
import 'package:pos_flutter/data/database.dart';
import 'package:pos_flutter/screens/inventory_screen/inventory_list.dart';
import 'package:pos_flutter/widgets/generic_search_bar.dart';

class PosBody extends StatefulWidget {
  const PosBody({super.key});

  @override
  _PosBodyState createState() => _PosBodyState();
}

class _PosBodyState extends State<PosBody> {
  String _searchQuery = '';

  List<ProductData> _filteredItems = [];
  List<ProductData> _allItems = [];
  bool isPercentageDiscount = false;
  double discount = 0.0;
  double tendered = 0.0;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<InventoryBloc>().add(LoadInventory());
    context.read<InvoiceBloc>().add(LoadProducts());
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (state is InvoiceError) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Error: ${state.message}"),
                    backgroundColor: Colors.red),
              );
            });
          }
          if (state is InvoiceSubmitted) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Invoice submitted successfully!"),
                    backgroundColor: Colors.green),
              );
            });
          }
        },
        child: BlocBuilder<InvoiceBloc, InvoiceState>(
          builder: (context, invoiceState) {
            if (invoiceState is InvoiceLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (invoiceState is InvoiceLoaded ||
                invoiceState is InvoiceUpdated) {
              if (_allItems.isEmpty && invoiceState is InvoiceLoaded) {
                _allItems = invoiceState.products;
                _filteredItems = _allItems;
              }

              if (_allItems.isEmpty && invoiceState is InvoiceUpdated) {
                _allItems = invoiceState.products;
                _filteredItems = _allItems;
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GenericSearchBar(
                        hintText: 'Search items',
                        focusNode: _searchFocusNode,
                        onSearchChanged: (query) {
                          setState(() {
                            _searchQuery = query;
                            final items =
                                (invoiceState as InvoiceLoaded).products;
                            _filteredItems = items.where((item) {
                              final lowerQuery = _searchQuery.toLowerCase();
                              return item.name
                                  .toLowerCase()
                                  .contains(lowerQuery) ||
                                  item.description
                                      .toLowerCase()
                                      .contains(lowerQuery) ||
                                  item.sku.toLowerCase().contains(lowerQuery);
                            }).toList();
                          });
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: InventoryListWidget(
                          filteredItems: _filteredItems,
                          sales: const {},
                          onSingleTap:
                              (BuildContext context, int index, ProductData item) {
                            // Dispatch event to add selected item to the invoice
                            context
                                .read<InvoiceBloc>()
                                .add(AddToInvoice(item.id, item.price));
                          },
                          onRightClick:
                              (BuildContext context, int index, ProductData item) {
                            // Dispatch event to remove selected item from invoice
                            context
                                .read<InvoiceBloc>()
                                .add(RemoveFromInvoice(item.id));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: Text("No inventory data"));
          },
        ),
      ),
    );
  }
}
