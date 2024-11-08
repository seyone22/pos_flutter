import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

import '../../data/database.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {




  InventoryBloc() : super(InventoryInitial()) {
    on<InventoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
