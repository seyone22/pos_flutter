import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter/util/date_utils.dart';

import '../../../util/currency_utils.dart';

class SalesLineChart extends StatelessWidget {
  final Map<DateTime, double> salesHistory;
  final double chartHeight;

  const SalesLineChart({
    super.key,
    required this.salesHistory, this.chartHeight = 270,
  });

  List<FlSpot> generateFlSpots(Map<DateTime, double> salesHistory) {

    return salesHistory.entries.map((entry) {
      return FlSpot(entry.key.day.toDouble(), entry.value);
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now(); // Use current date or modify as needed

    return SizedBox(
      height: chartHeight,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: generateFlSpots(salesHistory),
              isCurved: false,
              color: Theme.of(context).colorScheme.primary,
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  maxIncluded: false,
                  minIncluded: false,
                  getTitlesWidget: (value, _) => Text(formatAxisValue(value)),
                )),
            rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 1,
                showTitles: true,
                getTitlesWidget: (value, _) => Text(
                  DateFormat.E().format(
                    weekOfStart(selectedDate)
                        .add(Duration(days: (value-2).toInt())),
                  ),
                ),
              ),
            ),
          ),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
