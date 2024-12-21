import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter/data/database.dart';

class InvoiceListView extends StatefulWidget {
  final List<InvoiceData> invoices;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<CustomerData> customers;

  const InvoiceListView({
    super.key,
    required this.invoices,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.customers,
  });

  @override
  _InvoiceListViewState createState() => _InvoiceListViewState();
}

class _InvoiceListViewState extends State<InvoiceListView> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  void _sort<T>(Comparable<T> Function(InvoiceData) getField, int columnIndex) {
    setState(() {
      if (_sortColumnIndex == columnIndex) {
        _sortAscending = !_sortAscending;
      } else {
        _sortAscending = true;
        _sortColumnIndex = columnIndex;
      }

      widget.invoices.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return _sortAscending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          headingRowColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.surfaceDim,
          ),
          columns: [
            DataColumn(
              label: const Text('Invoice ID'),
              onSort: (index, _) => _sort((i) => i.id, index),
            ),
            DataColumn(
              label: const Text('Timestamp'),
              onSort: (index, _) => _sort((i) => i.timestamp, index),
            ),
            DataColumn(
              label: const Text('Customer Name'),
              onSort: (index, _) => _sort(
                      (i) => widget.customers
                      .firstWhere(
                        (c) => c.id == i.customer_id,
                    orElse: () =>
                    const CustomerData(id: 0, name: 'Unknown', email: '', phone_number: '', address: ''),
                  )
                      .name,
                  index),
            ),
            DataColumn(
              label: const Text('Subtotal'),
              numeric: true,
              onSort: (index, _) => _sort((i) => i.subtotal, index),
            ),
            DataColumn(
              label: const Text('Discount'),
              numeric: true,
              onSort: (index, _) => _sort((i) => i.discount_amount, index),
            ),
            DataColumn(
              label: const Text('Total'),
              numeric: true,
              onSort: (index, _) => _sort((i) => i.total, index),
            ),
            DataColumn(
              label: const Text('Tendered'),
              numeric: true,
              onSort: (index, _) => _sort((i) => i.tendered, index),
            ),
          ],
          rows: List<DataRow>.generate(
            widget.invoices.length,
                (index) {
              final item = widget.invoices[index];
              final customer = widget.customers.firstWhere(
                    (c) => c.id == item.id,
                orElse: () => const CustomerData(
                  id: 0, name: 'Unknown', email: '', phone_number: '', address: '',
                ),
              );

              return DataRow(
                selected: index == widget.selectedIndex,
                color: WidgetStateProperty.resolveWith((states) {
                  return index == widget.selectedIndex
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null;
                }),
                onSelectChanged: (selected) {
                  if (selected != null && selected) {
                    widget.onItemSelected(index);
                  }
                },
                cells: [
                  DataCell(Text(item.id.toString())),
                  DataCell(Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(item.timestamp))),
                  DataCell(Text(customer.name)),
                  DataCell(_formatCurrency(item.subtotal)),
                  DataCell(
                    item.discount_amount == 0
                        ? const Text('-')
                        : item.discount_type == 'PERCENT'
                        ? Text('${item.discount_amount}%')
                        : _formatCurrency(item.discount_amount),
                  ),
                  DataCell(_formatCurrency(item.total)),
                  DataCell(_formatCurrency(item.tendered, isBold: true)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _formatCurrency(double amount, {bool isBold = false}) {
    return Text(
      NumberFormat.currency(locale: 'en_IN', symbol: 'Rs.').format(amount),
      style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
