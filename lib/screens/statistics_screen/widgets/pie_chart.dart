import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesPieChart extends StatelessWidget {
  final Map<String, double> chartDataMap;
  final double chartRadius;

  const SalesPieChart({
    super.key,
    required this.chartDataMap,
    this.chartRadius = 130
  });

  @override
  Widget build(BuildContext context) {
    final pieChartData = chartDataMap.entries
        .map((entry) => PieChartSectionData(
      value: entry.value,
      title: '${entry.key}: ${entry.value.toStringAsFixed(2)}',
      color: _getRandomColor(entry.key),
      radius: chartRadius,
      titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    ))
        .toList();

    return SizedBox(
      height: 285, // Height of the Pie Chart
      width: double.infinity,
      child: PieChart(
        PieChartData(
          sections: pieChartData,
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 0, // No space in the center of the pie chart
        ),
      ),
    );
  }

  Color _getRandomColor(String key) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
    ];
    return colors[key.hashCode % colors.length];
  }
}
