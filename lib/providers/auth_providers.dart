import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>(
  (ref) => AuthController(ref.read(authServiceProvider)),
);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authStateChanges;
});