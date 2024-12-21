import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:pos_flutter/blocs/invoice/invoice_bloc.dart';
import 'package:pos_flutter/data/database.dart';
import 'package:pos_flutter/screens/invoice_list_screen/widgets/invoice_list.dart';
import 'package:pos_flutter/widgets/generic_search_bar.dart';

class InvoiceListBody extends StatefulWidget {
  const InvoiceListBody({super.key});

  @override
  _InvoiceListBodyState createState() => _InvoiceListBodyState();
}

class _InvoiceListBodyState extends State<InvoiceListBody> {
  List<InvoiceData> _filteredItems = [];
  List<InvoiceData> _allItems = [];
  int _selectedIndex = 0;
  List<CustomerData> _customersList = [];

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Dispatch an event to load inventory data when the screen is loaded
    context.read<InvoiceBloc>().add(const LoadInvoices());
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems.where((item) {
          final lowerQuery = query.toLowerCase();
          return item.customer_id.toString().contains(lowerQuery) ||
              item.payment_method.toLowerCase().contains(lowerQuery);
        }).toList();
      }
    });
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
              if (_allItems.isEmpty && invoiceState is InvoiceLoaded) {
                _allItems = invoiceState.invoiceList;
                _filteredItems = _allItems;
                _customersList = invoiceState.customersList;
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
                child: Column(
                  children: [
                    // Using Flexible or a SingleChildScrollView to allow scrolling
                    Flexible(
                        child: Expanded(
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GenericSearchBar(
                                  hintText: 'Search invoices',
                                  focusNode: _searchFocusNode,
                                  onSearchChanged: (value) {
                                    setState(() {
                                      _selectedIndex = 0;
                                      _filterItems(value);
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                width: double.infinity,
                                child: // Invoice List View Integration
                                    InvoiceListView(
                                  invoices: _filteredItems,
                                  customers: _customersList,
                                  selectedIndex: _selectedIndex,
                                  onItemSelected: (index) {
                                    setState(() {
                                      _selectedIndex = index;
                                      context.read<InvoiceBloc>().add(
                                          GetInvoiceData(
                                              _filteredItems[_selectedIndex]
                                                  .id));
                                    });
                                  },
                                ),
                              ))
                            ]),
                      ),
                    )),
                  ],
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
