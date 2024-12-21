import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_flutter/data/database.dart';
import 'package:pos_flutter/data/repositories/customer_repository.dart';
import 'package:pos_flutter/data/repositories/invoice_repository.dart';
import 'package:pos_flutter/data/repositories/product_repository.dart';
import 'package:meta/meta.dart';

part 'invoice_event.dart';

part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final ProductRepository productRepository;
  final InvoiceRepository invoiceRepository;
  final CustomerRepository customerRepository;

  InvoiceBloc(
      {required this.productRepository,
      required this.invoiceRepository,
      required this.customerRepository})
      : super(InvoiceInitial()) {
    on<LoadInvoices>((event, emit) async {
      emit(InvoiceLoading());

      try {
        // Assuming the repository has a method to get all invoices
        final invoices = await invoiceRepository.getAllInvoices();
        final customers = await customerRepository.getAllCustomers();

        emit(InvoiceLoaded(
            products: const [],
            invoice: const [],
            invoiceProducts: const [],
            invoiceList: invoices,
            customersList: customers));
      } catch (e) {
        emit(InvoiceError(message: e.toString()));
      }
    });

    on<AddToInvoice>((event, emit) {
      if (state is InvoiceLoaded || state is InvoiceUpdated) {
        // Retrieve the current invoice items
        final currentItems = List<InvoiceProductData>.from(
            (state is InvoiceUpdated
                ? (state as InvoiceUpdated).invoiceProducts
                : (state as InvoiceLoaded).invoiceProducts));

        // Check if the product is already in the invoice
        final existingIndex = currentItems
            .indexWhere((item) => item.product_id == event.productId);

        if (existingIndex != -1) {
          // Increment the quantity if the product is already in the invoice
          currentItems[existingIndex] = currentItems[existingIndex].copyWith(
            quantity: currentItems[existingIndex].quantity + 1,
          );
        } else {
          // Add a new item if it is not already in the invoice
          currentItems.add(InvoiceProductData(
            id: 0,
            // Auto-incremented ID
            invoice_id: 0,
            // To be assigned when saving the invoice
            product_id: event.productId,
            quantity: 1,
            price: event.price,
          ));
        }

        // Emit the updated invoice state with the modified items
        emit(InvoiceUpdated(
          products: (state is InvoiceUpdated
              ? (state as InvoiceUpdated).products
              : (state as InvoiceLoaded)
                  .products), // Keep existing product list
          invoice: (state is InvoiceUpdated
              ? (state as InvoiceUpdated).invoice
              : (state as InvoiceLoaded).invoice), // Keep existing invoice data
          invoiceProducts: currentItems, // Updated invoice products
        ));
      }
    });

    // Load inventory when the event is dispatched
    on<LoadProducts>((event, emit) async {
      try {
        emit(InvoiceLoading());

        // Fetch products from the repository (via the ProductRepository)
        final products = await productRepository.getAllProductItems();

        emit(InvoiceLoaded(
            products: products,
            invoice: List.empty(),
            invoiceProducts: List.empty(),
            invoiceList: List.empty(),
            customersList: List.empty()));
      } catch (e) {
        emit(const InvoiceError(message: "Failed to load inventory."));
      }
    });

    on<RemoveFromInvoice>((event, emit) {
      if (state is InvoiceLoaded || state is InvoiceUpdated) {
        // Retrieve the current invoice items
        final currentItems = List<InvoiceProductData>.from(
            (state is InvoiceUpdated
                ? (state as InvoiceUpdated).invoiceProducts
                : (state as InvoiceLoaded).invoiceProducts));

        // Find the index of the product in the invoice
        final existingIndex = currentItems
            .indexWhere((item) => item.product_id == event.productId);

        if (existingIndex != -1) {
          final existingItem = currentItems[existingIndex];

          if (existingItem.quantity > 1) {
            // Decrement the quantity if greater than 1
            currentItems[existingIndex] = existingItem.copyWith(
              quantity: existingItem.quantity - 1,
            );
          } else {
            // Remove the item if the quantity is 1
            currentItems.removeAt(existingIndex);
          }

          // Emit the updated invoice state with the modified items
          emit(InvoiceUpdated(
            products: (state is InvoiceUpdated
                ? (state as InvoiceUpdated).products
                : (state as InvoiceLoaded)
                    .products), // Keep existing product list
            invoice: (state is InvoiceUpdated
                ? (state as InvoiceUpdated).invoice
                : (state as InvoiceLoaded)
                    .invoice), // Keep existing invoice data
            invoiceProducts: currentItems, // Updated invoice products
          ));
        }
      }
    });

    on<DeleteFromInvoice>((event, emit) {
      if (state is InvoiceLoaded || state is InvoiceUpdated) {
        // Retrieve the current invoice items
        final currentItems = List<InvoiceProductData>.from(
            (state is InvoiceUpdated
                ? (state as InvoiceUpdated).invoiceProducts
                : (state as InvoiceLoaded).invoiceProducts));

        // Find the index of the product in the invoice
        final existingIndex = currentItems
            .indexWhere((item) => item.product_id == event.productId);

        if (existingIndex != -1) {
          final existingItem = currentItems[existingIndex];

          if (existingItem.quantity > 0) {
            // Remove the item
            currentItems.removeAt(existingIndex);
          }

          // Emit the updated invoice state with the modified items
          emit(InvoiceUpdated(
            products: (state is InvoiceUpdated
                ? (state as InvoiceUpdated).products
                : (state as InvoiceLoaded)
                    .products), // Keep existing product list
            invoice: (state is InvoiceUpdated
                ? (state as InvoiceUpdated).invoice
                : (state as InvoiceLoaded)
                    .invoice), // Keep existing invoice data
            invoiceProducts: currentItems, // Updated invoice products
          ));
        }
      }
    });

    on<SubmitInvoice>((event, emit) async {
      try {
        if (state is InvoiceUpdated) {
          final currentState = state as InvoiceUpdated;

          // Example: Assuming you have a service or repository to handle invoice submissions
          await invoiceRepository.submitInvoice(
              event.invoice, event.productList, event.customer);

          // Reassign invoice to an empty list (avoiding modification of a fixed-length list)
          final updatedState = currentState.copyWith(
            invoice: [], // Clear the invoice by reassigning to an empty list
          );

          // Emit a success state
          emit(InvoiceSubmitted(
            products: currentState.products,
            invoice: currentState.invoice,
            invoiceProducts: currentState.invoiceProducts,
            invoiceList: List.empty(),
            customersList: List.empty(),
          ));

          LoadProducts();
          emit(InvoiceLoaded(
            products: currentState.products,
            invoice: currentState.invoice,
            invoiceProducts: currentState.invoiceProducts,
            invoiceList: List.empty(),
            customersList: List.empty(),
          ));
        } else {
          // If the state is not InvoiceUpdated, emit an error state
          emit(const InvoiceError(
              message: 'Cannot submit invoice: Invalid state.'));
        }
      } catch (error) {
        // Emit an error state if submission fails
        emit(InvoiceError(message: 'Submission Failed: $error.'));
      }
    });

    on<GetInvoiceData>((event, emit) async {
      try {
        final invoice = await invoiceRepository.getInvoiceById(event.invoiceId);
        final products =
            await invoiceRepository.getProductsForInvoice(event.invoiceId);
        final invoiceProducts = await invoiceRepository.getInvoiceProductsForInvoice(event.invoiceId);

        emit(InvoiceSelected(products: products, invoice: invoice, invoiceProducts: invoiceProducts));
      } catch (e) {
        emit(InvoiceError(message: e.toString()));
      }
    });
  }
}
