import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/src/auth/domain/auth_repository.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail_repository.dart';

class Authenticator {
  const Authenticator(
    this._repository,
    this._userDetailRepository,
  );

  final IAuthRepository _repository;
  final IUserDetailRepository _userDetailRepository;

  Future<User?> signInWithGoogle() async {
    final User? user = await _repository.signInWithGoogle();
    final UserDetail? userDetail = user == null
        ? null
        : await _userDetailRepository.save(
            UserDetail(uid: user.uid, username: user.displayName ?? ''),
          );
    if (userDetail == null) {
      await _repository.logout();
      return null;
    }
    return user;
  }
}
