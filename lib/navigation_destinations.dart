import 'package:flutter/material.dart';

List<NavigationDestination> navDestinations = const [
  NavigationDestination(
    icon: Icon(Icons.inventory_outlined),
    selectedIcon: Icon(Icons.inventory),
    label: 'Stock',
  ),
  NavigationDestination(
    icon: Icon(Icons.receipt_outlined),
    selectedIcon: Icon(Icons.receipt),
    label: 'POS',
  ),
  NavigationDestination(
    icon: Icon(Icons.document_scanner_outlined),
    selectedIcon: Icon(Icons.document_scanner),
    label: 'Invoices',
  ),
  NavigationDestination(
    icon: Icon(Icons.numbers_outlined),
    selectedIcon: Icon(Icons.numbers),
    label: 'Stats',
  ),
];
