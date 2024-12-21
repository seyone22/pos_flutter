import '../database.dart';

class CustomerRepository {
  final AppDatabase db;

  CustomerRepository({required this.db});

  // Get all items in the inventory
  Future<List<CustomerData>> getAllCustomers() {
    return db.getAllCustomers();
  }
}