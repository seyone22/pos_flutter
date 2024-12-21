part of 'inventory_bloc.dart';

@immutable
abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class LoadInventory extends InventoryEvent { }

class AddInventoryItem extends InventoryEvent {
  final int product_id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String sku;
  final int artwork_id;

  const AddInventoryItem({
    required this.product_id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.sku,
    required this.artwork_id
  });

  @override
  List<Object> get props => [product_id, name, description, price, stock, sku, artwork_id];
}

class RestockInventoryItem extends InventoryEvent {
  final int productId;
  final int newStockAmount;
  final int supplierId;

  const RestockInventoryItem({
    required this.productId,
    required this.newStockAmount,
    required this.supplierId
  });

  @override
  List<Object> get props => [newStockAmount, supplierId];
}

class AdjustInventoryItem extends InventoryEvent {
  final int productId;
  final int adjustmentAmount;
  final String type;

  const AdjustInventoryItem({
    required this.productId,
    required this.adjustmentAmount,
    required this.type
  });

  @override
  List<Object> get props => [productId, adjustmentAmount, type];
}

class RemoveInventoryItem extends InventoryEvent {
  final int product_id;

  const RemoveInventoryItem({
    required this.product_id,
  });

  @override
  List<Object> get props => [product_id];
}

// Event for editing an inventory item
class EditInventoryItem extends InventoryEvent {
  final int product_id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String sku;
  final int artwork_id; // Assuming artwork_id exists

  const EditInventoryItem({
    required this.product_id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.sku,
    required this.artwork_id,
  });

  @override
  List<Object> get props => [product_id, name, description, price, stock, sku, artwork_id];
}

class ExportInventory extends InventoryEvent { }

class ExportInventoryReconciliation extends InventoryEvent { }

class ImportInventory extends InventoryEvent { }