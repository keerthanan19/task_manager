import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String? email;
  final bool isEmailVerified;

  AppUser(this.uid, this.email, this.isEmailVerified);

  factory AppUser.fromFirebaseUser(User? user) {
    if (user == null) throw Exception('User is null');
    return AppUser(user.uid, user.email, user.emailVerified);
  }
}
