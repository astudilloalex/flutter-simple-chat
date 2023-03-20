import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail_repository.dart';

class UserDetailService {
  const UserDetailService(this._repository);

  final IUserDetailRepository _repository;
  static UserDetail? _currentUser;

  Future<UserDetail?> currentUser({bool refresh = false}) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    if (refresh) _currentUser = await _repository.findByUid(user.uid);
    return _currentUser ??= await _repository.findByUid(user.uid);
  }

  Stream<List<UserDetail>> getContacts() {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    return _repository.contacts(uid ?? '');
  }

  Future<void> addContact(String uid) async {
    if (await _repository.existUser(uid)) {
      return _repository.addContact(uid);
    }
    throw Exception('user-does-not-exist');
  }

  Stream<UserDetail?> findById(String uid) {
    return _repository.findById(uid);
  }
}
