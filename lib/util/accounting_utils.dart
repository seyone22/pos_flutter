// lib/utils/accounting_utils.dart
import '../data/database.dart';

// Sum of all sales transactions before any deductions like discounts or taxes
double calculateGrossSales(List<InvoiceData> salesData) {
  return salesData.fold(0.0, (sum, data) => sum + data.subtotal);
}

// Sum of all sales after taxes and other charges, minus discounts
double calculateTotalRevenue(List<InvoiceData> salesData) {
  return salesData.fold(0.0, (sum, data) => sum + data.total);
}

// Sum of all discounts applied across all sales
double calculateDiscountVolume(List<InvoiceData> salesData) {
  return salesData.fold(0.0, (sum, data) {
    double discount = 0.0;

    if (data.discount_type == 'FIXED') {
      discount = data.discount_amount;
    } else if (data.discount_type == 'PERCENT') {
      discount = data.subtotal * (data.discount_amount / 100);
    }

    return sum + discount;
  });
}

// Sum of all taxes collected on all sales

// The overall profitability, including sales, costs, and expenses
double calculateNetSales(List<InvoiceData> salesData) {
  return salesData.fold(0.0, (sum, data) => sum + data.total);
}