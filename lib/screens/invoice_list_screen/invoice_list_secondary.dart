import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:pos_flutter/blocs/invoice/invoice_bloc.dart';
import 'package:pos_flutter/screens/invoice_list_screen/widgets/invoice_detail_panel.dart';
import 'package:pos_flutter/screens/invoice_list_screen/widgets/invoice_items_panel.dart';

class InvoiceListSecondary extends StatefulWidget {
  const InvoiceListSecondary({super.key});

  @override
  _InvoiceListSecondaryState createState() => _InvoiceListSecondaryState();
}

class _InvoiceListSecondaryState extends State<InvoiceListSecondary> {
  final int _selectedIndex = 0;

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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
            // Schedule the Snackbar to be shown after the current build frame
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error: ${state.message}"),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            });
          }
          if (state is InvoiceSubmitted) {
            // Schedule the Snackbar to be shown after the current build frame
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Invoice submitted successfully!"),
                  backgroundColor: Colors.green, // Success background color
                  duration: Duration(seconds: 3),
                ),
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
                invoiceState is InvoiceUpdated ||
                invoiceState is InvoiceSelected) {
              final selectedInvoice = (invoiceState is InvoiceSelected)
                  ? invoiceState.invoice
                  : null;
              final invoiceProducts = (invoiceState is InvoiceSelected)
                ? invoiceState.invoiceProducts
                  :null;
              final products = (invoiceState is InvoiceSelected)
                  ? invoiceState.products
                  :null;

              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
                child: Expanded(
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InvoiceDetailsPanel(
                            selectedInvoice: selectedInvoice),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        flex: 2,
                        child: InvoiceItemsPanel(
                            invoiceProducts: invoiceProducts, products: products),
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
