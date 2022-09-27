import 'package:flutter/material.dart';

enum TabItem {
  red(color: Colors.red),
  green(color: Colors.green),
  blue(color: Colors.blue);

  const TabItem({required this.color});

  final MaterialColor color;
}
