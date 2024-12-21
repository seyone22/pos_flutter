import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/blocs/inventory/inventory_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:pos_flutter/blocs/invoice/invoice_bloc.dart';
import 'package:pos_flutter/data/database.dart';
import 'package:pos_flutter/screens/pos_screen/widgets/invoice_summary.dart';

class PosSecondary extends StatefulWidget {
  const PosSecondary({super.key});

  @override
  _PosSecondaryState createState() => _PosSecondaryState();
}

class _PosSecondaryState extends State<PosSecondary> {
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
                padding: const EdgeInsets.all(16.0),
                child: Expanded(
                  child: InvoiceSummary(
                    invoiceState: invoiceState,
                    isPercentageDiscount: isPercentageDiscount,
                    discount: discount,
                    tendered: tendered,
                    onDiscountChanged: (value) => setState(() {
                      isPercentageDiscount = value;
                    }),
                    onTenderedChanged: (value) => setState(() {
                      tendered = value;
                    }),
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
