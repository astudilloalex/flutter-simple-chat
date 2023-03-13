import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/src/auth/domain/auth_repository.dart';

class AuthHandler {
  const AuthHandler(this._authRepository);

  final IAuthRepository _authRepository;

  Future<User?> get currentUser => _authRepository.currentUser;
}
