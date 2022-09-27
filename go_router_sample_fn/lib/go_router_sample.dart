import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'presentation/home_page.dart';
import 'presentation/login_page.dart';
import 'service/auth_service.dart';

class GoRouterSample extends StatefulWidget {
  const GoRouterSample({super.key});

  @override
  State<GoRouterSample> createState() => _GoRouterSampleState();
}

class _GoRouterSampleState extends State<GoRouterSample> {
  late Stream<User?> authState;

  @override
  void initState() {
    authState = FirebaseAuth.instance.authStateChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      final isLogin = await context.read<AuthService>().isLogin();
      final loggingIn = state.subloc == '/login';
      if (!isLogin) {
        return loggingIn ? null : '/login';
      }

      if (loggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage<HomePage>(
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => const MaterialPage<HomePage>(
          child: LoginPage(),
        ),
      ),
    ],
  );
}
