import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesBarChart extends StatelessWidget {
  final Map<String, double> chartDataMap;
  final double chartHeight;

  const SalesBarChart({
    super.key,
    required this.chartDataMap,
    this.chartHeight = 270
  });

  @override
  Widget build(BuildContext context) {
    final barChartData = chartDataMap.entries
        .map((entry) => BarChartGroupData(
      x: chartDataMap.keys.toList().indexOf(entry.key),
      barRods: [
        BarChartRodData(
          toY: entry.value,
          color: _getRandomColor(entry.key),
          width: 40,
          borderRadius: BorderRadius.zero,
        ),
      ],
    ))
        .toList();

    return SizedBox(
      height: chartHeight,
      width: double.infinity,
      child: BarChart(
        duration: const Duration(milliseconds: 500),
        BarChartData(
          gridData: const FlGridData(show: true),
          titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  minIncluded: false,
                  maxIncluded: false,
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    final title = chartDataMap.keys.toList()[value.toInt()];
                    return Text(
                      title,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 44,
                  minIncluded: false,
                  maxIncluded: false,
                  showTitles: true,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              )),
          borderData: FlBorderData(show: false),
          barGroups: barChartData,
        ),
      ),
    );
  }

  Color _getRandomColor(String key) {
    final colors = [
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.redAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
    ];
    return colors[key.hashCode % colors.length];
  }
}
