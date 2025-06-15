import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter/data/database.dart'; // Replace with your actual database import

class SalesDataTable extends StatefulWidget {
  final Map<String, double> salesDataMap; // ProductId -> Items Sold
  final List<ProductData> products; // List of products with details

  const SalesDataTable({
    Key? key,
    required this.salesDataMap,
    required this.products,
  }) : super(key: key);

  @override
  _SalesDataTableState createState() => _SalesDataTableState();
}

class _SalesDataTableState extends State<SalesDataTable> {
  late List<Map<String, dynamic>> _tableData; // Enriched data for table
  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  @override
  void initState() {
    super.initState();
    _enrichTableData();
  }

  void _enrichTableData() {
    _tableData = widget.salesDataMap.entries.map((entry) {
      final product = widget.products.firstWhere(
              (product) => product.id.toString() == entry.key,
          orElse: () => ProductData(
              id: int.parse(entry.key),
              name: 'Unknown',
              description: 'N/A',
              artworkId: 0,
              price: 0.0,
              stock: 0,
              sku: 'N/A')); // Default values if product not found
      return {
        'productId': entry.key,
        'productName': product.name,
        'description': product.description,
        'price': product.price,
        'stock': product.stock,
        'sales': entry.value.toInt(),
      };
    }).toList();
  }

  void _sortData(int columnIndex) {
    setState(() {
      _currentSortColumn = columnIndex;
      _isSortAsc = !_isSortAsc;

      // Sorting logic
      switch (columnIndex) {
        case 0: // Product ID
          _tableData.sort((a, b) => _isSortAsc
              ? a['productId'].compareTo(b['productId'])
              : b['productId'].compareTo(a['productId']));
          break;
        case 1: // Product Name
          _tableData.sort((a, b) => _isSortAsc
              ? a['productName'].compareTo(b['productName'])
              : b['productName'].compareTo(a['productName']));
          break;
        case 2: // Description
          _tableData.sort((a, b) => _isSortAsc
              ? a['description'].compareTo(b['description'])
              : b['description'].compareTo(a['description']));
          break;
        case 3: // Price
          _tableData.sort((a, b) => _isSortAsc
              ? a['price'].compareTo(b['price'])
              : b['price'].compareTo(a['price']));
          break;
        case 4: // Stock
          _tableData.sort((a, b) => _isSortAsc
              ? a['stock'].compareTo(b['stock'])
              : b['stock'].compareTo(a['stock']));
          break;
        case 5: // Sales
          _tableData.sort((a, b) => _isSortAsc
              ? a['sales'].compareTo(b['sales'])
              : b['sales'].compareTo(a['sales']));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          sortAscending: _isSortAsc,
          sortColumnIndex: _currentSortColumn,
          headingRowColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.surfaceVariant),
          columns: [
            DataColumn(
              label: const Text('Product ID'),
              onSort: (columnIndex, _) => _sortData(columnIndex),
            ),
            DataColumn(
              label: const Text('Name'),
              onSort: (columnIndex, _) => _sortData(columnIndex),
            ),
            DataColumn(
              label: const Text('Description'),
              onSort: (columnIndex, _) => _sortData(columnIndex),
            ),
            DataColumn(
              numeric: true,
              label: const Text('Price'),
              onSort: (columnIndex, _) => _sortData(columnIndex),
            ),
            DataColumn(
              numeric: true,
              label: const Text('Stock'),
              onSort: (columnIndex, _) => _sortData(columnIndex),
            ),
            DataColumn(
              numeric: true,
              label: const Text('Sales'),
              onSort: (columnIndex, _) => _sortData(columnIndex),
            ),
          ],
          rows: _tableData
              .map((data) => DataRow(
            cells: [
              DataCell(Text(data['productId'])),
              DataCell(Text(data['productName'])),
              DataCell(Text(data['description'])),
              DataCell(Text(
                NumberFormat.currency(
                  locale: 'si_LK',
                  symbol: 'Rs.',
                  decimalDigits: 2,
                ).format(data['price']),
              )),
              DataCell(Text(data['stock'].toString())),
              DataCell(Text(data['sales'].toString())),
            ],
          ))
              .toList(),
        ),
      ),
    );
  }
}
