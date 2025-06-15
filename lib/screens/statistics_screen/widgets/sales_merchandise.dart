import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/data/database.dart';
import 'package:file_picker/file_picker.dart'; // For file picking
import 'package:pos_flutter/screens/statistics_screen/widgets/table.dart';

import '../../../blocs/statistics/statistics_bloc.dart';

class SalesMerchandise extends StatefulWidget {
  final DateTimeRange selectedDateRange;
  final List<ProductData> products;

  const SalesMerchandise({
    super.key,
    required this.selectedDateRange,
    required this.products,
  });

  @override
  State<SalesMerchandise> createState() => _SalesMerchandiseState();
}

class _SalesMerchandiseState extends State<SalesMerchandise> {
  String selectedOption = 'Count'; // Option for switching between count and value

  // Method to export sales data as CSV
  Future<void> exportSalesData(Map<String, double> salesData) async {
    try {
      // Generate CSV content
      final csvContent = StringBuffer();
      csvContent.writeln('Product ID,Product Name,SKU,Description,Price,Sales'); // Add headers

      for (final entry in salesData.entries) {
        final product = widget.products.firstWhere(
              (p) => p.id == int.parse(entry.key),
          orElse: () => const ProductData(
            id: 0,
            name: 'Unknown',
            description: '',
            price: 0.0,
            stock: 0,
            sku: '',
            artworkId: 0,
          ),
        );

        // Write enriched data to CSV
        csvContent.writeln(
          '${entry.key},'
              '${product.name},'
              '${product.sku},'
              '"${product.description}",' // Use quotes for text with commas
              '${product.price},'
              '${entry.value}',
        );
      }

      // Open file picker to choose location and filename
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Sales Data as CSV',
        fileName: 'sales_data.csv',
      );

      if (result != null) {
        final file = File(result);
        await file.writeAsString(csvContent.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File saved successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File save cancelled')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export sales data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (state is StatisticsLoaded) {
              final salesByProduct = state.salesByProduct;

              if (salesByProduct.isEmpty) {
                return const Center(child: Text('No sales data available'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By Item Category',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => exportSalesData(salesByProduct),
                            child: const Text('Export'),
                          ),
                          const SizedBox(width: 8),
                          SegmentedButton(
                            segments: const [
                              ButtonSegment(value: 'Count', label: Text('Count')),
                              ButtonSegment(value: 'Value', label: Text('Value')),
                            ],
                            selected: {selectedOption},
                            onSelectionChanged: (Set<String> newValue) {
                              setState(() {
                                selectedOption = newValue.first ?? 'Count';
                              });
                              context.read<StatisticsBloc>().add(
                                LoadSalesByProduct(
                                  dateRange: widget.selectedDateRange,
                                  metric: selectedOption,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SalesDataTable(
                    salesDataMap: salesByProduct,
                    products: widget.products,
                  ),
                ],
              );
            } else if (state is StatisticsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Error loading data'));
            }
          },
        ),
      ),
    );
  }
}
