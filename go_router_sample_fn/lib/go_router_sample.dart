import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_sample_fn/const/constants.dart';
import 'package:go_router_sample_fn/const/tab_item.dart';
import 'package:go_router_sample_fn/presentation/color_detail_page.dart';
import 'package:go_router_sample_fn/presentation/colors_list_page.dart';
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
    initialLocation: '/${TabItem.red.name}',
    redirect: (context, state) async {
      final isLogin = await context.read<AuthService>().isLogin();
      final loggingIn = state.subloc == '/login';
      if (!isLogin) {
        return loggingIn ? null : '/login';
      }

      if (loggingIn) {
        return '/${TabItem.red.name}}';
      }

      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
    routes: [
      ShellRoute(
        builder: (context, state, child) => HomePage(child: child),
        routes: TabItem.values
            .map(
              (tabItem) => GoRoute(
                path: '/${tabItem.name}',
                builder: (context, state) => ColorsListPage(tabItem: tabItem),
                routes: materialIndices
                    .map(
                      (index) => GoRoute(
                        path: ':index',
                        builder: (context, state) {
                          int materialIndex;
                          try {
                            materialIndex = int.parse(state.params['index']!);
                          } on Exception catch (e) {
                            return Scaffold(
                              body: Center(
                                child: Text('Error: $e'),
                              ),
                            );
                          }
                          if (!materialIndices.contains(materialIndex)) {
                            return const Scaffold(
                              body: Center(
                                child: Text('There is no page.'),
                              ),
                            );
                          }
                          materialIndex = int.parse(state.params['index']!);
                          return ColorDetailPage(
                            color: tabItem.color,
                            title: tabItem.name,
                            materialIndex: materialIndex,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}
