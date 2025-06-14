import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/routes.dart';
import 'package:task_manager/providers/auth_providers.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(authStateChangesProvider, (_, state) {
      state.whenData((user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, Routes.login);
        } else {
          Navigator.pushReplacementNamed(context, Routes.taskList);
        }
      });
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}