import 'package:simple_chat/src/user_detail/domain/user_detail.dart';

abstract class IUserDetailRepository {
  const IUserDetailRepository();

  Future<void> addContact(String uid);
  Stream<List<UserDetail>> contacts(String uid);
  Future<bool> existUser(String uid);
  Future<UserDetail?> findByUid(String uid);
  Future<UserDetail?> save(UserDetail user);
}
