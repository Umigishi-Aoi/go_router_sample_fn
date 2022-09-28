import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_sample_fn/service/auth_service.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../const/tab_item.dart';

/// To avoid  "Do not use BuildContexts across async gaps.",
/// I use Stateful Widget.
///
/// "ja"
///
/// "Do not use BuildContexts across async gaps."を避けるために、
/// Stateful Widgetを使っています。
class ColorsListPage extends StatefulWidget {
  const ColorsListPage({
    super.key,
    required this.tabItem,
  });

  final TabItem tabItem;

  @override
  State<ColorsListPage> createState() => _ColorsListPageState();
}

class _ColorsListPageState extends State<ColorsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tabItem.name,
        ),
        backgroundColor: widget.tabItem.color,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthService>().logout();
              if (!mounted) {
                return;
              }
              context.go('/login');
            },
          ),
        ],
      ),
      body: ColoredBox(
        color: Colors.white,
        child: ListView.builder(
          itemCount: materialIndices.length * 5,
          itemBuilder: (BuildContext content, int index) {
            final materialIndex =
                materialIndices[index % materialIndices.length];
            return Container(
              color: widget.tabItem.color[materialIndex],
              child: ListTile(
                title: Text(
                  '$materialIndex',
                  style: const TextStyle(fontSize: 40),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => {
                  context.go(
                    '/${widget.tabItem.name}/$materialIndex',
                  ),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
