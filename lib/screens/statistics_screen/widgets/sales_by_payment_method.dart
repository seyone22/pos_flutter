import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/pie_chart.dart';

import '../../../blocs/statistics/statistics_bloc.dart';

class SalesByPaymentMethod extends StatefulWidget {
  final DateTimeRange selectedDateRange;

  const SalesByPaymentMethod({
    super.key,
    required this.selectedDateRange,
  });

  @override
  State<SalesByPaymentMethod> createState() => _SalesByPaymentMethodState();
}

class _SalesByPaymentMethodState extends State<SalesByPaymentMethod> {
  String selectedOption =
      'Count'; // Example option for switching between count and volume

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (state is StatisticsLoaded) {
              final salesByPaymentMethod =
                  state.salesByPaymentMethod; // Map<String, double>

              if (salesByPaymentMethod.isEmpty) {
                return const Center(child: Text('No sales data available'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By Payment Method',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SegmentedButton(segments: const [
                        ButtonSegment(value: 'Count', label: Text('1')),
                        ButtonSegment(value: 'Value', label: Text('#'))
                      ], selected: {selectedOption},onSelectionChanged: (Set<String> newValue) {
                        setState(() {
                          selectedOption = newValue.first ?? 'Count';
                          context.read<StatisticsBloc>().add(
                              LoadSalesByPaymentMethod(
                                  dateRange: widget.selectedDateRange,
                                  metric: selectedOption));
                        });
                      },),
                    ],
                  ),
                  SalesPieChart(chartDataMap: salesByPaymentMethod),
                  // Pass filtered data to the chart
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
