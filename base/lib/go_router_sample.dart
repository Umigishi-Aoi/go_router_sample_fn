import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'presentation/home_page.dart';
import 'presentation/login_page.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: authState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.hasData) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
