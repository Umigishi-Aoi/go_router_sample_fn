import 'package:flutter/material.dart';
import 'package:go_router_sample_fn/const/tab_item.dart';
import 'package:go_router_sample_fn/presentation/colors_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: TabItem.values.indexOf(_currentTab),
        children: const [
          ColorsListPage(
            tabItem: TabItem.red,
          ),
          ColorsListPage(
            tabItem: TabItem.green,
          ),
          ColorsListPage(
            tabItem: TabItem.blue,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: TabItem.values.map((tabItem) {
          return NavigationDestination(
            icon: Icon(
              Icons.layers,
              color: _colorTabMatching(tabItem),
            ),
            label: tabItem.name,
          );
        }).toList(),
        selectedIndex: TabItem.values.indexOf(_currentTab),
        onDestinationSelected: (index) {
          setState(() {
            _currentTab = TabItem.values[index];
          });
        },
      ),
    );
  }

  Color _colorTabMatching(TabItem item) {
    return _currentTab == item ? item.color : Colors.grey;
  }
}
