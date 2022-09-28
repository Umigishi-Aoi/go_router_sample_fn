import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_sample_fn/const/tab_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: TabItem.values.map((tabItem) {
          return NavigationDestination(
            icon: Icon(
              Icons.layers,
              color: _colorTabMatching(tabItem, context),
            ),
            label: tabItem.name,
          );
        }).toList(),
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) {
          _onItemTapped(index, context);
        },
      ),
    );
  }

  Color _colorTabMatching(TabItem item, BuildContext context) {
    final route = GoRouter.of(context);
    final location = route.location;
    final currentTabItem = TabItem.values.firstWhere(
      (tabItem) => location.contains('/${tabItem.name}'),
      orElse: () => TabItem.red,
    );
    return currentTabItem == item ? item.color : Colors.grey;
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final route = GoRouter.of(context);
    final location = route.location;
    final tabItem = TabItem.values.firstWhere(
      (tabItem) => location.contains('/${tabItem.name}'),
      orElse: () => TabItem.red,
    );
    return tabItem.index;
  }

  void _onItemTapped(int index, BuildContext context) {
    final tabItem = TabItem.values[index];
    final route = GoRouter.of(context);
    final location = route.location;
    if (location == '/${tabItem.name}') {
      return;
    }
    route.go('/${tabItem.name}');
  }
}
