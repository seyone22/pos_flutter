import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_flutter/data/repositories/product_repository.dart';
import 'package:pos_flutter/util/accounting_utils.dart';
import '../../data/database.dart';
import '../../data/repositories/invoice_repository.dart';
import '../../screens/statistics_screen/widgets/date_selector.dart';

part 'statistics_event.dart';

part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final InvoiceRepository invoiceRepository;
  final ProductRepository productRepository;

  // Private functions
  Future<void> _emitUpdatedStatistics(
    Emitter<StatisticsState> emit, {
    double? grossSales,
    double? totalRevenue,
    double? discountVolume,
    double? netSales,
    Map<DateTime, double>? salesHistory,
    Map<String, double>? salesByType,
    Map<String, double>? salesByPaymentMethod,
    Map<String, double>? salesByArtist,
    Map<String, double>? salesByItemCategory,
  }) async {
    if (state is StatisticsLoaded) {
      final previous = state as StatisticsLoaded;
      emit(StatisticsLoaded(
        grossSales: grossSales ?? previous.grossSales,
        totalRevenue: totalRevenue ?? previous.totalRevenue,
        discountVolume: discountVolume ?? previous.discountVolume,
        netSales: netSales ?? previous.netSales,
        salesHistory: salesHistory ?? previous.salesHistory,
        salesByType: salesByType ?? previous.salesByType,
        salesByPaymentMethod:
            salesByPaymentMethod ?? previous.salesByPaymentMethod,
        salesByArtist: salesByArtist ?? previous.salesByArtist,
        salesByItemCategory:
            salesByItemCategory ?? previous.salesByItemCategory,
      ));
    }
  }

  Future<Map<String, double>> groupByField({
    required List<InvoiceData> invoices,
    required Future<String> Function(InvoiceProductData) keyExtractor,
    required String metric,
  }) async {
    final Map<String, double> result = {};

    for (var invoice in invoices) {
      final invoiceProducts =
          await invoiceRepository.getInvoiceProductsForInvoice(invoice.id);

      for (var invoiceProduct in invoiceProducts) {
        final key = await keyExtractor(invoiceProduct);
        var value = metric == 'Count'
            ? 1.0
            : invoiceProduct.quantity * invoiceProduct.price;

        result.update(key, (existing) => existing + value,
            ifAbsent: () => value);
      }
    }
    return result;
  }

  // Main functions
  StatisticsBloc(
      {required this.invoiceRepository, required this.productRepository})
      : super(StatisticsInitial()) {
    // Load all sales data
    on<LoadSalesData>((event, emit) async {
      try {
        emit(StatisticsLoading());

        // Fetch invoices
        final salesData = await invoiceRepository.getInvoicesByDateRange(
            event.dateRange.start, event.dateRange.end);

        final grossSales = calculateGrossSales(salesData);
        final totalRevenue =
            salesData.fold(0.0, (sum, data) => sum + data.total);
        final discountVolume = calculateDiscountVolume(salesData);
        final netSales = calculateNetSales(salesData);

        emit(StatisticsLoaded(
          grossSales: grossSales,
          totalRevenue: totalRevenue,
          discountVolume: discountVolume,
          netSales: netSales,
          salesHistory: const {},
          salesByType: const {},
        ));
      } catch (e) {
        emit(StatisticsError(message: e.toString()));
      }
    });

    on<LoadSalesByType>((event, emit) async {
      try {
        // Fetch invoices within the date range
        final invoices = await invoiceRepository.getInvoicesByDateRange(
            event.dateRange.start, event.dateRange.end);

        // Group sales values by type
        final Map<String, double> valueByType = await groupByField(
            invoices: invoices,
            keyExtractor: (invoiceProduct) async {
              final product = await productRepository
                  .getProductById(invoiceProduct.product_id);
              return product.description;
            },
            metric: event.metric);

        await _emitUpdatedStatistics(emit, salesByType: valueByType);
      } catch (e) {
        emit(StatisticsError(message: e.toString()));
      }
    });

    on<LoadSalesByPaymentMethod>((event, emit) async {
      try {
        // Fetch invoices within the date range
        final invoices = await invoiceRepository.getInvoicesByDateRange(
            event.dateRange.start, event.dateRange.end);

        // Group sales values by type
        final Map<String, double> valueByPaymentMethod = {};

        for (var invoice in invoices) {
          final paymentMethod = invoice.payment_method;
          var invoiceTotal = invoice.total;

          // Adjust the total based on the metric
          if (event.metric == 'Count') {
            invoiceTotal = 1;
          }

          // Accumulate sales by payment method
          if (valueByPaymentMethod.containsKey(paymentMethod)) {
            valueByPaymentMethod[paymentMethod] =
                valueByPaymentMethod[paymentMethod]! + invoiceTotal;
          } else {
            valueByPaymentMethod[paymentMethod] = invoiceTotal;
          }
        }

        await _emitUpdatedStatistics(emit,
            salesByPaymentMethod: valueByPaymentMethod);
      } catch (e) {
        emit(StatisticsError(message: e.toString()));
      }
    });

    on<LoadSalesByArtist>((event, emit) async {
      try {
        // Fetch invoices within the date range
        final invoices = await invoiceRepository.getInvoicesByDateRange(
            event.dateRange.start, event.dateRange.end);

        // Group sales values by artist
        final valueByArtist = await groupByField(
          invoices: invoices,
          metric: event.metric,
          keyExtractor: (invoiceProduct) async {
            final product = await productRepository
                .getProductById(invoiceProduct.product_id);
            return product.name.substring(0, 4); // Extract artist prefix
          },
        );

        await _emitUpdatedStatistics(emit, salesByArtist: valueByArtist);
      } catch (e) {
        emit(StatisticsError(message: e.toString()));
      }
    });

    on<LoadSalesByItemCategory>((event, emit) async {
      try {
        // Fetch invoices within the date range
        final invoices = await invoiceRepository.getInvoicesByDateRange(
            event.dateRange.start, event.dateRange.end);

        // Group sales values by item category
        final valueByItemCategory = await groupByField(
          invoices: invoices,
          metric: event.metric,
          keyExtractor: (invoiceProduct) async {
            final product = await productRepository
                .getProductById(invoiceProduct.product_id);
            final prefix = product.name.substring(0, 3).toUpperCase(); // Extract type prefix
            // Categorize based on prefix
            return prefix == 'NPP' ? 'NPP' : 'APP';
          },
        );

        debugPrint('Length: ${valueByItemCategory.length}');

        await _emitUpdatedStatistics(emit, salesByItemCategory: valueByItemCategory);
      } catch (e) {
        emit(StatisticsError(message: e.toString()));
      }
    });

    on<LoadSalesHistory>((event, emit) async {
      try {
        emit(StatisticsLoading());

        // Fetch invoices within the date range
        final invoices = await invoiceRepository.getInvoicesByDateRange(
            event.dateRange.start, event.dateRange.end);

        // Create a Map to hold the sales data, with days of the week as keys
        final salesHistory = <DateTime, double>{};

        // Iterate over the days in the range
        for (int i = 0;
            i <= event.dateRange.end.difference(event.dateRange.start).inDays;
            i++) {
          final currentDate = event.dateRange.start.add(Duration(days: i));

          // Normalize the current date to midnight (ignoring time)
          final normalizedCurrentDate =
              DateTime(currentDate.year, currentDate.month, currentDate.day);

          // Calculate daily sales for the normalized date
          final dailySales = invoices.where(
            (invoice) {
              final normalizedTimestamp = DateTime(
                invoice.timestamp.year,
                invoice.timestamp.month,
                invoice.timestamp.day,
              );
              return normalizedTimestamp
                  .isAtSameMomentAs(normalizedCurrentDate);
            },
          ).fold(0.0, (sum, invoice) => sum + invoice.total);

          // Add the sales data to the map with the day of the week as the key
          salesHistory[currentDate] = dailySales;
        }

        _emitUpdatedStatistics(emit, salesHistory: salesHistory);
      } catch (e) {
        emit(StatisticsError(message: e.toString()));
      }
    });
  }
}
