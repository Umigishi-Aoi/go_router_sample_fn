import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../const/tab_item.dart';
import '../service/auth_service.dart';

/// To avoid  "Do not use BuildContexts across async gaps.",
/// I use Stateful Widget.
///
/// "ja"
///
/// "Do not use BuildContexts across async gaps."を避けるために、
/// Stateful Widgetを使っています。
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Login'),
          onPressed: () async {
            await context.read<AuthService>().loginAnonymously();
            if (!mounted) {
              return;
            }
            context.go('/${TabItem.red.name}');
          },
        ),
      ),
    );
  }
}
