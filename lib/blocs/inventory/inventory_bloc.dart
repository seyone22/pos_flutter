import 'dart:io';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/database.dart';
import 'package:csv/csv.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final ProductRepository productRepository;

  InventoryBloc({required this.productRepository}) : super(InventoryInitial()) {
    // Load inventory when the event is dispatched
    on<LoadInventory>((event, emit) async {
      try {
        emit(InventoryLoading());

        // Fetch products from the repository (via the ProductRepository)
        final products = await productRepository.getAllProductItems();
        final sales = await productRepository.getSalesForAllProducts();

        emit(InventoryLoaded(items: products, sales: sales));
      } catch (e) {
        emit(const InventoryError(message: "Failed to load inventory."));
      }
    });

    // Add an inventory item
    on<AddInventoryItem>((event, emit) async {
      try {
        // Add the item to the inventory via the repository
        await productRepository.addProductItem(
          event.product_id,
          event.name,
          event.description,
          event.price,
          event.stock,
          event.sku,
          event.artwork_id,
        );

        // Refresh the inventory list
        final products = await productRepository.getAllProductItems();
        final previous = state as InventoryLoaded;
        emit(InventoryLoaded(items: products, sales: previous.sales));
      } catch (e) {
        emit(InventoryError(message: "Insert Failed: $e"));
      }
    });

    on<RestockInventoryItem>((event, emit) async {
      try {
        // Add the restock to the database
        await productRepository.restockProduct(event.productId, event.newStockAmount, event.supplierId);

        // Refresh the inventory list
        final products = await productRepository.getAllProductItems();
        final previous = state as InventoryLoaded;
        emit(InventoryLoaded(items: products, sales: previous.sales));
      } catch (e) {
        emit(InventoryError(message: e.toString()));
      }
    });

    on<AdjustInventoryItem>((event, emit) async {
      try {
        // Add the restock to the database
        await productRepository.adjustProduct(event.productId, event.adjustmentAmount, event.type);

        // Refresh the inventory list
        final products = await productRepository.getAllProductItems();
        final previous = state as InventoryLoaded;
        emit(InventoryLoaded(items: products, sales: previous.sales));
      } catch (e) {
        emit(InventoryError(message: e.toString()));
      }
    });

    // Remove an inventory item
    on<RemoveInventoryItem>((event, emit) async {
      try {
        // Remove the item from the inventory via the repository
        await productRepository.removeProductItem(event.product_id);

        // Refresh the inventory list
        final products = await productRepository.getAllProductItems();
        final previous = state as InventoryLoaded;
        emit(InventoryLoaded(items: products, sales: previous.sales));
      } catch (e) {
        emit(const InventoryError(message: "Failed to remove inventory item."));
      }
    });

    // Edit an inventory item
    on<EditInventoryItem>((event, emit) async {
      try {
        // Edit the item to the inventory via the repository
        await productRepository.updateProductItem(
          event.product_id,
          event.name,
          event.description,
          event.price,
          event.stock,
          event.sku,
          event.artwork_id,
        );

        // Refresh the inventory list
        final products = await productRepository.getAllProductItems();
        final previous = state as InventoryLoaded;
        emit(InventoryLoaded(items: products, sales: previous.sales));
      } catch (e) {
        emit(InventoryError(message: "Edit Failed: $e"));
      }
    });

    // Helper function to pick a file path (directory + filename) for saving the file
    Future<String?> pickFilePath() async {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Inventory as JSON',
        fileName: 'inventory.json', // Default file name
        allowedExtensions: ['json'], // Allow only JSON files
      );
      return result; // This will return the full file path or null if canceled
    }

    // Helper function to convert a single product to JSON
    Map<String, dynamic> productToJson(ProductData product) {
      return {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'stock': product.stock,
        'sku': product.sku,
        'artworkId': product.artworkId,
      };
    }

    // Convert inventory list to JSON string
    String inventoryToJson(List<ProductData> products) {
      List<Map<String, dynamic>> productList =
          products.map((product) => productToJson(product)).toList();
      return jsonEncode(productList);
    }

    // Helper function to export to JSON at selected path
    Future<void> exportToJson(
        List<ProductData> items, String directory) async {
      final String jsonString = inventoryToJson(items);
      final file = File(directory);
      await file.writeAsString(jsonString);
    }

    // Export inventory to JSON
    on<ExportInventory>((event, emit) async {
      try {
        if (state is InventoryLoaded) {
          final items = (state as InventoryLoaded).items;
          final filePath = await pickFilePath(); // Get file path with filename
          if (filePath != null) {
            await exportToJson(
                items, filePath); // Save the file at the selected path

            // Fetch products from the repository (via the ProductRepository)
            final products = await productRepository.getAllProductItems();

            emit(InventoryLoaded(items: products));
          } else {
            emit(const InventoryError(message: "No file path selected."));
          }
        }
      } catch (e) {
        emit(InventoryError(message: "Failed to export inventory: $e"));
      }
    });

    // Helper method to save the CSV content to a file
    Future<void> exportToFile(String csvData, String filePath) async {
      final file = File(filePath);
      await file.writeAsString(csvData);
    }

// Export inventory to CSV
    on<ExportInventoryReconciliation>((event, emit) async {
      try {
        if (state is InventoryLoaded) {
          final items = (state as InventoryLoaded).items;
          final filePath = await pickFilePath(); // Get file path with filename

          if (filePath != null) {
            // Select the columns you want to include in the CSV
            // Example: you can choose item name, price, and stock as columns
            List<List<String>> rows = [];

            // Add header row with column names
            rows.add(['Name','SKU', 'Price', 'Stock']);

            // Add each item data as a row in the CSV
            for (var item in items) {
              rows.add([item.name, item.sku, item.price.toString(), item.stock.toString()]);
            }

            // Convert rows to CSV format
            String csvData = const ListToCsvConverter().convert(rows);

            // Save the CSV file at the selected path
            await exportToFile(csvData, filePath);

            // Fetch products from the repository (via the ProductRepository)
            final products = await productRepository.getAllProductItems();

            emit(InventoryLoaded(items: products));
          } else {
            emit(const InventoryError(message: "No file path selected."));
          }
        }
      } catch (e) {
        emit(InventoryError(message: "Failed to export inventory: $e"));
      }
    });


    // Helper function to pick a file for importing
    Future<String?> pickFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        return result.files.single.path; // Return the file path
      }

      return null; // No file selected
    }

    Future<List<ProductData>?> importInventory() async {
      final filePath = await pickFile();
      if (filePath == null) return null; // If no file is picked, return null

      try {
        final file = File(filePath);
        final content = await file.readAsString();

        final List<dynamic> jsonData = jsonDecode(content);

// Convert the JSON data to ProductData objects
        final List<ProductData> products = jsonData.map((item) {
          return ProductData(
            id: 0, // Default value for id
            name: item['name'] ?? 'Unnamed Product', // Default if name is null
            description: item['description'] ??
                'No description available', // Default if description is null
            price: (item['price'] != null && item['price'] is num)
                ? (item['price'] as num).toDouble()
                : 0.0, // Safely handle null or non-numeric price
            stock: item['stock'] != null && item['stock'].toString().isNotEmpty
                ? int.tryParse(item['stock'].toString()) ?? 0
                : 0, // Safely handle null or non-numeric stock
            sku: item['sku'] ?? '', // Default to empty string if sku is null
            artworkId: item['artworkId'] != null &&
                    item['artworkId'].toString().isNotEmpty
                ? int.tryParse(item['artworkId'].toString()) ?? 0
                : 0, // Safely handle null or non-numeric artworkId
          );
        }).toList();

        return products; // Return the list of products
      } catch (e) {
        return null;
      }
    }



    // Make sure this is inside the constructor
    on<ImportInventory>((event, emit) async {
      try {
        final products = await importInventory();
        if (products != null) {
          // Add the products to the database or update the state
          for (var product in products) {
            await productRepository.addProductItem(
              product.id,
              product.name,
              product.description,
              product.price,
              product.stock,
              product.sku,
              product.artworkId,
            );
          }

          // Refresh the inventory list after importing
          final updatedProducts = await productRepository.getAllProductItems();
          emit(InventoryLoaded(items: updatedProducts));
        } else {
          emit(const InventoryError(message: "Failed to import inventory."));
        }
      } catch (e) {
        emit(InventoryError(message: "Import Failed: $e"));
      }
    });
  }
}
