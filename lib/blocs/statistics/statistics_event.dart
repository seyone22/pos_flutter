part of 'statistics_bloc.dart';

@immutable
abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object> get props => [];
}

// Base class for events with startDate and endDate
abstract class SalesDateRangeEvent extends StatisticsEvent {
  final DateTimeRange dateRange;
  final String metric;

  const SalesDateRangeEvent({
    required this.dateRange,
    this.metric = 'Count',
  });

  @override
  List<Object> get props => [dateRange, metric];
}

class LoadSalesData extends SalesDateRangeEvent {
  const LoadSalesData({required super.dateRange, super.metric});
}

class LoadSalesHistory extends SalesDateRangeEvent {
  const LoadSalesHistory({required super.dateRange, super.metric});
}

class LoadSalesByType extends SalesDateRangeEvent {
  const LoadSalesByType({required super.dateRange, super.metric});
}

class LoadSalesByArtist extends SalesDateRangeEvent {
  const LoadSalesByArtist({required super.dateRange, super.metric});
}

class LoadSalesByPaymentMethod extends SalesDateRangeEvent {
  const LoadSalesByPaymentMethod({required super.dateRange, super.metric});
}

class LoadSalesByProduct extends SalesDateRangeEvent {
  const LoadSalesByProduct({required super.dateRange, super.metric});
}

class LoadSalesByItemCategory extends SalesDateRangeEvent {
  const LoadSalesByItemCategory({required super.dateRange, super.metric});
}