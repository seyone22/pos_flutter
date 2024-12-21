import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter/data/database.dart';

class InventoryListWidget extends StatefulWidget {
  final List<ProductData> filteredItems;
  final Map<int, int> sales;
  final Function(BuildContext, int, ProductData)? onSingleTap;
  final Function(BuildContext, int, ProductData)? onDoubleTap;
  final Function(BuildContext, int, ProductData)? onRightClick;
  final Function(BuildContext, int, ProductData)? onLongPress;

  const InventoryListWidget({
    super.key,
    required this.filteredItems,
    required this.sales,
    this.onSingleTap,
    this.onDoubleTap,
    this.onRightClick,
    this.onLongPress,
  });

  @override
  _InventoryListWidgetState createState() => _InventoryListWidgetState();
}

class _InventoryListWidgetState extends State<InventoryListWidget> {
  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  late List<ProductData> _sortedItems;

  @override
  void initState() {
    super.initState();
    _sortedItems =
        List.from(widget.filteredItems); // Initialize with filteredItems
  }

  void _sortList(int columnIndex) {
    setState(() {
      _currentSortColumn = columnIndex;
      _isSortAsc = !_isSortAsc;

      // Sort the list based on the selected column
      if (_currentSortColumn == 0) {
        // Sort by Name
        _sortedItems.sort((a, b) =>
            _isSortAsc ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
      } else if (_currentSortColumn == 1) {
        // Sort by Description
        _sortedItems.sort((a, b) => _isSortAsc
            ? a.description.compareTo(b.description)
            : b.description.compareTo(a.description));
      } else if (_currentSortColumn == 2) {
        // Sort by Price
        _sortedItems.sort((a, b) => _isSortAsc
            ? a.price.compareTo(b.price)
            : b.price.compareTo(a.price));
      } else if (_currentSortColumn == 3) {
        // Sort by Stock
        _sortedItems.sort((a, b) => _isSortAsc
            ? a.stock.compareTo(b.stock)
            : b.stock.compareTo(a.stock));
      } else if (_currentSortColumn == 4) {
        // Sort by SKU
        _sortedItems.sort((a, b) =>
            _isSortAsc ? a.sku.compareTo(b.sku) : b.sku.compareTo(a.sku));
      }
    });
  }

  @override
  void didUpdateWidget(covariant InventoryListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If filteredItems change (e.g., due to search), update _sortedItems
    if (oldWidget.filteredItems != widget.filteredItems) {
      setState(() {
        _sortedItems = List.from(widget.filteredItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          showCheckboxColumn: false,
          sortAscending: _isSortAsc,
          sortColumnIndex: _currentSortColumn,
          headingRowColor: WidgetStateProperty.all(Theme.of(context)
              .colorScheme
              .surfaceDim,),
          columns: [
            DataColumn(
              label: const Text('Name'),
              onSort: (columnIndex, _) {
                _sortList(columnIndex);
              },
            ),
            DataColumn(
                label: const Text('Description'),
                onSort: (columnIndex, _) {
                  _sortList(columnIndex);
                }),
            DataColumn(
                numeric: true,
                label: const Text('Price'),
                onSort: (columnIndex, _) {
                  _sortList(columnIndex);
                }),
            DataColumn(
                numeric: true,
                label: const Text('Stock'),
                onSort: (columnIndex, _) {
                  _sortList(columnIndex);
                }),
            DataColumn(
                label: const Text('SKU'),
                onSort: (columnIndex, _) {
                  _sortList(columnIndex);
                }),
            DataColumn(
                numeric: true,
                label: const Text('Sales'),
                onSort: (columnIndex, _) {
                  _sortList(columnIndex);
                })
          ],
          rows: List<DataRow>.generate(
            _sortedItems.length,
            (int index) {
              final item = _sortedItems[index];
              return _buildDataRow(
                  context, index, item, widget.sales[item.id] ?? 0);
            },
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(
      BuildContext context, int index, ProductData item, int sales) {
    return DataRow(
      selected: false,
      onSelectChanged: (bool? selected) {
        if (selected != null && selected) {
          // Single Tap Action
          if (widget.onSingleTap != null) {
            widget.onSingleTap!(context, index, item);
          }
        }
      },
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue.withOpacity(0.08);
          }
          if (index.isEven) {
            return Colors.grey.withOpacity(0.3);
          }
          return null;
        },
      ),
      cells: [
        DataCell(Text(item.name)),
        DataCell(Text(item.description)),
        DataCell(Text(
          NumberFormat.currency(
            locale: 'si_LK',
            symbol: 'Rs.',
            decimalDigits: 2,
          ).format(item.price),
        )),
        DataCell(Text(item.stock.toString())),
        DataCell(Text(item.sku.toString())),
        DataCell(Text(sales.toString())),
      ],
      onLongPress: () {
        if (widget.onLongPress != null) {
          widget.onLongPress!(context, index, item);
        }
      },
    );
  }
}
