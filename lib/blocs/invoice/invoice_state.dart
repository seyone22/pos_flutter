part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceSubmitted extends InvoiceState {
  final List<ProductData> products;
  final List<InvoiceData> invoice;
  final List<InvoiceProductData> invoiceProducts;
  final List<InvoiceData> invoiceList;
  final List<CustomerData> customersList;

  const InvoiceSubmitted({
    required this.products,
    required this.invoice,
    required this.invoiceProducts,
    required this.invoiceList,
    required this.customersList,
  });

  @override
  List<Object> get props => [
        products,
        invoice,
        invoiceProducts,
        invoiceList,
        customersList,
      ];

  // Corrected copyWith method with InvoiceSubmitted return type
  InvoiceSubmitted copyWith({
    List<ProductData>? products,
    List<InvoiceData>? invoice,
    List<InvoiceProductData>? invoiceProducts,
    List<InvoiceData>? invoiceList,
    List<CustomerData>? customersList,
  }) {
    return InvoiceSubmitted(
      products: products ?? this.products,
      invoice: invoice ?? this.invoice,
      invoiceProducts: invoiceProducts ?? this.invoiceProducts,
      invoiceList: invoiceList ?? this.invoiceList,
      customersList: customersList ?? this.customersList,
    );
  }
}

class InvoiceLoaded extends InvoiceState {
  final List<ProductData> products;
  final List<InvoiceData> invoice;
  final List<InvoiceProductData> invoiceProducts;
  final List<InvoiceData> invoiceList;
  final List<CustomerData> customersList;

  const InvoiceLoaded({
    required this.products,
    required this.invoice,
    required this.invoiceProducts,
    required this.invoiceList,
    required this.customersList,
  });

  @override
  List<Object> get props => [
        products,
        invoice,
        invoiceProducts,
        invoiceList,
        customersList,
      ];
}

class InvoiceError extends InvoiceState {
  final String message;

  const InvoiceError({required this.message});

  @override
  List<Object> get props => [message];
}

class InvoiceUpdated extends InvoiceState {
  final List<ProductData> products;
  final List<InvoiceData> invoice;
  final List<InvoiceProductData> invoiceProducts;

  const InvoiceUpdated({
    required this.products,
    required this.invoice,
    required this.invoiceProducts,
  });

  @override
  List<Object> get props => [products, invoice, invoiceProducts];

  // Corrected copyWith method with InvoiceUpdated return type
  InvoiceUpdated copyWith({
    List<ProductData>? products,
    List<InvoiceData>? invoice,
    List<InvoiceProductData>? invoiceProducts,
  }) {
    return InvoiceUpdated(
      products: products ?? this.products,
      invoice: invoice ?? this.invoice,
      invoiceProducts: invoiceProducts ?? this.invoiceProducts,
    );
  }
}

class InvoiceSelected extends InvoiceState {
  final List<ProductData> products;
  final InvoiceData invoice;
  final List<InvoiceProductData> invoiceProducts;

  const InvoiceSelected({required this.products, required this.invoice, required this.invoiceProducts});

  @override
  List<Object> get props => [products, invoice, invoiceProducts];
}
