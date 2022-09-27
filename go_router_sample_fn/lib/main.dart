import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router_sample_fn/service/auth_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'go_router_sample.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    Provider<AuthService>(
      create: (context) => const AuthService(),
      child: const GoRouterSample(),
    ),
  );
}
