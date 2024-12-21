import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/statistics/statistics_bloc.dart';
import 'bar_chart.dart';

class SalesByType extends StatefulWidget {
  final DateTimeRange selectedDateRange;
  final double height;

  const SalesByType({
    super.key,
    required this.selectedDateRange,
    required this.height,
  });

  @override
  State<SalesByType> createState() => _SalesByTypeState();
}

class _SalesByTypeState extends State<SalesByType> {
  String selectedOption = 'Count';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (state is StatisticsLoaded) {
              final salesByType =
                  state.salesByType ?? {}; // Map<String, double>

              if (salesByType.isEmpty) {
                return const Center(child: Text('No sales data available'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By Merch Type',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      // Dropdown for switching between count and volume
                      SegmentedButton(segments: const [
                        ButtonSegment(value: 'Count', label: Text('1')),
                        ButtonSegment(value: 'Value', label: Text('#'))
                      ], selected: {selectedOption},onSelectionChanged: (Set<String> newValue) {
                        setState(() {
                          selectedOption = newValue.first ?? 'Count';
                          context.read<StatisticsBloc>().add(
                              LoadSalesByType(
                                  dateRange: widget.selectedDateRange,
                                  metric: selectedOption));
                        });
                      },),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SalesBarChart(
                    chartDataMap: salesByType,
                    chartHeight: widget.height * 0.68,
                  ),
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
