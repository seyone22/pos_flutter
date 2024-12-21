part of 'inventory_bloc.dart';

@immutable
abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<ProductData> items;
  final Map<int, int> sales;

  const InventoryLoaded({required this.items, this.sales = const {}});

  @override
  List<Object> get props => [items];
}

class InventoryError extends InventoryState {
  final String message;

  const InventoryError({required this.message});

  @override
  List<Object> get props => [message];
}
