import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter/blocs/statistics/statistics_bloc.dart';

class StatisticsView extends StatelessWidget {
  final DateTimeRange selectedDateRange;

  const StatisticsView({
    super.key,
    required this.selectedDateRange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (state is StatisticsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StatisticsLoaded) {
              return SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: <DataColumn>[
                    const DataColumn(
                      label: Text(
                        'Gross Sales',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        NumberFormat.currency(locale: 'en_IN', symbol: 'Rs. ')
                            .format(state.grossSales),
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        const DataCell(Text('Discount Volume')),
                        DataCell(
                          Text(
                            NumberFormat.currency(
                                    locale: 'en_IN', symbol: 'Rs. ')
                                .format(state.discountVolume),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        const DataCell(Text('Return Volume')),
                        DataCell(
                          Text(
                            NumberFormat.currency(
                                locale: 'en_IN', symbol: 'Rs. ')
                                .format(0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        const DataCell(Text('Allowance Volume')),
                        DataCell(
                          Text(
                            NumberFormat.currency(
                                locale: 'en_IN', symbol: 'Rs. ')
                                .format(0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        const DataCell(Text(
                          'Net Sales',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataCell(
                          Text(
                            NumberFormat.currency(
                                    locale: 'en_IN', symbol: 'Rs. ')
                                .format(state.netSales),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is StatisticsError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const Center(child: Text("No statistics available"));
          },
        ),
      ),
    );
  }
}
