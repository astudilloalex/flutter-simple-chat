import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  const IAuthRepository();

  Future<User?> get currentUser;
  Future<void> logout();
  Future<User?> signInWithGoogle();
}
