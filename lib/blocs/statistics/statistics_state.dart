part of 'statistics_bloc.dart';

@immutable
abstract class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object> get props => [];
}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final double grossSales;
  final double totalRevenue;
  final double discountVolume;
  final double netSales;
  final Map<DateTime, double> salesHistory;
  final Map<String, double> salesByType;
  final Map<String, double> salesByArtist;
  final Map<String, double> salesByPaymentMethod;
  final Map<String, double> salesByProduct;
  final Map<String, double> salesByItemCategory;

  final Calendar dateRange;

  const StatisticsLoaded({
    required this.grossSales,
    required this.totalRevenue,
    required this.discountVolume,
    required this.netSales,
    required this.salesHistory,
    this.salesByType = const {},
    this.salesByArtist = const {},
    this.salesByPaymentMethod = const {},
    this.salesByProduct = const {},
    this.salesByItemCategory = const {},

    this.dateRange = Calendar.day
  });

  @override
  List<Object> get props => [
        grossSales,
        totalRevenue,
        discountVolume,
        netSales,
        salesHistory,
        salesByType,
        salesByArtist,
        salesByPaymentMethod,
        salesByProduct,
        salesByItemCategory,
        dateRange
      ];
}

class StatisticsError extends StatisticsState {
  final String message;

  const StatisticsError({required this.message});

  @override
  List<Object> get props => [message];
}
