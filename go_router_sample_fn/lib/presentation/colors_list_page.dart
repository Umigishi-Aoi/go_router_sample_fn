import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../const/constants.dart';
import '../const/tab_item.dart';
import 'color_detail_page.dart';

class ColorsListPage extends StatelessWidget {
  const ColorsListPage({
    super.key,
    required this.tabItem,
  });

  final TabItem tabItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tabItem.name,
        ),
        backgroundColor: tabItem.color,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
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
              color: tabItem.color[materialIndex],
              child: ListTile(
                title: Text(
                  '$materialIndex',
                  style: const TextStyle(fontSize: 40),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute<ColorDetailPage>(
                      builder: (context) => ColorDetailPage(
                        color: tabItem.color,
                        title: tabItem.name,
                        materialIndex: materialIndex,
                      ),
                    ),
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
