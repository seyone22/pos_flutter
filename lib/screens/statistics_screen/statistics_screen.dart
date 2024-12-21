import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/blocs/statistics/statistics_bloc.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_by_artist.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_by_item_category.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_by_payment_method.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_by_type.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_chart.dart';
import 'widgets/statistics_view.dart';
import 'widgets/date_selector.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DateTimeRange selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap the body content in a SingleChildScrollView
        padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateSelector(
              selectedDateRange: selectedDateRange,
              onDateSelected: (dateRange) {
                setState(() => selectedDateRange = dateRange);

                final bloc = context.read<StatisticsBloc>();
                bloc.add(LoadSalesData(dateRange: dateRange));
                bloc.add(LoadSalesHistory(dateRange: dateRange));
                bloc.add(LoadSalesByType(dateRange: dateRange));
                bloc.add(LoadSalesByPaymentMethod(dateRange: dateRange));
                bloc.add(LoadSalesByArtist(dateRange: dateRange));
                bloc.add(LoadSalesByItemCategory(dateRange: dateRange));
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1, // First child takes 1/3 of the available width
                  child: SizedBox(
                    height: 400, // Fixed height
                    child: StatisticsView(selectedDateRange: selectedDateRange),
                  ),
                ),
                Flexible(
                  flex: 2, // Second child takes 2/3 of the available width
                  child: SizedBox(
                    height: 400, // Fixed height
                    child: SalesChart(
                      selectedDateRange: selectedDateRange,
                      height: 400,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2, // First child takes 1/3 of the available width
                  child: SizedBox(
                    height: 400, // Fixed height
                    child: SalesByArtist(
                        selectedDateRange: selectedDateRange, height: 400),
                  ),
                ),
                Flexible(
                  flex: 1, // Second child takes 2/3 of the available width
                  child: SizedBox(
                    height: 400, // Fixed height
                    child: SalesByPaymentMethod(
                        selectedDateRange: selectedDateRange),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1, // Second child takes 2/3 of the available width
                  child: SizedBox(
                    height: 400, // Fixed height
                    child: SalesByItemCategory(
                        selectedDateRange: selectedDateRange),
                  ),
                ),
                Flexible(
                  flex: 2, // First child takes 1/3 of the available width
                  child: SizedBox(
                    height: 400, // Fixed height
                    child: SalesByType(
                        selectedDateRange: selectedDateRange, height: 400),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
