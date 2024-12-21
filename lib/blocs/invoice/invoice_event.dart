part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends InvoiceEvent {}

class LoadInvoices extends InvoiceEvent {
  // You can add parameters here if needed, like pagination or filters
  const LoadInvoices();
}

class SearchProducts extends InvoiceEvent {
  final String query;
  
  const SearchProducts(this.query);

  @override
  List<Object> get props => [query];
}

class AddToInvoice extends InvoiceEvent {
  final int productId;
  final double price;

  const AddToInvoice(this.productId, this.price);

  @override
  List<Object> get props => [productId, price];
}

class RemoveFromInvoice extends InvoiceEvent {
  final int productId;

  const RemoveFromInvoice(this.productId);

  @override
  List<Object> get props => [productId];
}

class DeleteFromInvoice extends InvoiceEvent {
  final int productId;

  const DeleteFromInvoice(this.productId);

  @override
  List<Object> get props => [productId];
}

class SubmitInvoice extends InvoiceEvent {
  final InvoiceData invoice;
  final List<InvoiceProductData> productList;
  final CustomerData customer;


  const SubmitInvoice(this.invoice, this.productList, this.customer);
}

class GetInvoiceData extends InvoiceEvent {
  final int invoiceId;

  const GetInvoiceData(this.invoiceId);
}
