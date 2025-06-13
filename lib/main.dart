import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_manager/features/auth/controllers/auth_controller.dart';
import 'package:task_manager/features/auth/views/auth_screen.dart';
import 'package:task_manager/features/tasks/views/tasks_screen.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use your existing router configuration
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/tasks',
          builder: (context, state) => const TasksScreen(),
          redirect: (context, state) {
            final authState = ref.read(authControllerProvider);
            return authState is AuthSuccess ? null : '/';
          },
        ),
      ],
    );

    // Listen to auth state changes for navigation
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next is AuthSuccess) {
        router.go('/tasks');
      } else if (next is AuthInitial) {
        router.go('/');
      }
    });

    return MaterialApp.router(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}