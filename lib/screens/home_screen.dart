import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:pos_flutter/screens/inventory_screen/inventory_screen.dart';
import 'package:pos_flutter/screens/invoice_list_screen/invoice_list_body.dart';
import 'package:pos_flutter/screens/invoice_list_screen/invoice_list_secondary.dart';
import 'package:pos_flutter/screens/pos_screen/pos_body.dart';
import 'package:pos_flutter/screens/pos_screen/pos_secondary.dart';
import 'package:pos_flutter/screens/statistics_screen/statistics_screen.dart';
import 'package:pos_flutter/navigation_destinations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _bodyPages = const [
    InventoryScreen(),
    PosBody(),
    InvoiceListBody(),
    StatisticsScreen(),
  ];

  final List<Widget?> _secondaryPages = const [
    null,
    PosSecondary(),
    InvoiceListSecondary(),
    null,
  ];

  // A simple check to determine if the page has a secondary body
  bool _hasSecondaryBody(int index) {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AdaptiveLayout(
      bodyRatio: 0.7,
      // An option to override the default transition duration.
      transitionDuration: const Duration(milliseconds: 12),
      primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.standard: SlotLayout.from(
          inAnimation: AdaptiveScaffold.leftOutIn,
          key: const Key('Primary Navigation Medium'),
          builder: (_) => AdaptiveScaffold.standardNavigationRail(
            groupAlignment: 0,
            labelType: NavigationRailLabelType.all,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int newIndex) {
              setState(() {
                _selectedIndex = newIndex;
              });
            },
            destinations: navDestinations
                .map((NavigationDestination destination) =>
                    AdaptiveScaffold.toRailDestination(destination))
                .toList(),
          ),
        ),
      }),
      body: SlotLayout(config: <Breakpoint, SlotLayoutConfig?>{
        Breakpoints.standard: SlotLayout.from(
          key: const Key('body'),
          builder: (context) {
            // Return the correct screen based on the selected index
            return _bodyPages[_selectedIndex];
          },
        )
      }),
      secondaryBody: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig?>{
          if (_secondaryPages[_selectedIndex] != null)
            Breakpoints.standard: SlotLayout.from(
              key: const Key('secondaryBody'),
              builder: (context) => _secondaryPages[_selectedIndex]!,
            ),
        },
      ),
    ));
  }
}
