part of 'inventory_bloc.dart';

@immutable
abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class LoadInventory extends InventoryEvent { }

class AddInventoryItem extends InventoryEvent {
  final String product_id;
  final int quantity;

  const AddInventoryItem({
    required this.product_id,
    required this.quantity
  });

  @override
  List<Object> get props => [product_id, quantity];
}

class RemoveInventoryItem extends InventoryEvent {
  final String product_id;
  final int quantity;

  const RemoveInventoryItem({
    required this.product_id,
    required this.quantity
  });

  @override
  List<Object> get props => [product_id, quantity];
}