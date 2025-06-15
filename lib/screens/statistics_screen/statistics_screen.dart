import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/blocs/statistics/statistics_bloc.dart';
import 'package:pos_flutter/blocs/inventory/inventory_bloc.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_by_artist.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_by_item_category.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_by_payment_method.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_by_type.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_chart.dart';
import 'package:pos_flutter/screens/statistics_screen/widgets/sales_merchandise.dart';
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
                bloc.add(LoadSalesByProduct(dateRange: dateRange));
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 400,
                    child: StatisticsView(selectedDateRange: selectedDateRange),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    height: 400,
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
                  flex: 2,
                  child: SizedBox(
                    height: 400,
                    child: SalesByArtist(
                        selectedDateRange: selectedDateRange, height: 400),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 400,
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
                  flex: 1,
                  child: SizedBox(
                    height: 400,
                    child: SalesByItemCategory(
                        selectedDateRange: selectedDateRange),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    height: 400,
                    child: SalesByType(
                        selectedDateRange: selectedDateRange, height: 400),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 400,
                    child: BlocBuilder<InventoryBloc, InventoryState>(
                      builder: (context, state) {
                        if (state is InventoryLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is InventoryLoaded) {
                          return SalesMerchandise(
                            selectedDateRange: selectedDateRange,
                            products: state.items, // Pass products here
                          );
                        } else if (state is InventoryError) {
                          return Center(
                            child: Text('Error loading inventory: ${state.message}'),
                          );
                        } else {
                          return const Center(
                            child: Text('No data available'),
                          );
                        }
                      },
                    ),
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
