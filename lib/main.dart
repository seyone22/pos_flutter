import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/blocs/invoice/invoice_bloc.dart';
import 'package:pos_flutter/blocs/statistics/statistics_bloc.dart';
import 'package:pos_flutter/data/repositories/customer_repository.dart';
import 'package:pos_flutter/data/repositories/invoice_repository.dart';
import 'package:pos_flutter/data/repositories/product_repository.dart';
import 'package:pos_flutter/screens/home_screen.dart';
import 'package:system_theme/system_theme.dart'; // Import system_theme
import 'data/database.dart';
import 'blocs/inventory/inventory_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure SystemTheme is initialized
  await SystemTheme.accentColor.load();

  final database = AppDatabase();
  final productRepository = ProductRepository(db: database);
  final invoiceRepository = InvoiceRepository(db: database);
  final customerRepository = CustomerRepository(db: database);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            InventoryBloc(productRepository: productRepository),
      ),
      BlocProvider(
          create: (context) => InvoiceBloc(
              productRepository: productRepository,
              invoiceRepository: invoiceRepository,
              customerRepository: customerRepository)),
      BlocProvider(
        create: (context) => StatisticsBloc(invoiceRepository: invoiceRepository, productRepository: productRepository)
      )
    ],
    child: MyApp(
      database: database,
      seedColor: SystemTheme.accentColor.accent,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  final Color seedColor;

  const MyApp({super.key, required this.database, required this.seedColor});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
