import 'package:simple_chat/src/user_detail/domain/user_detail.dart';

abstract class IUserDetailRepository {
  const IUserDetailRepository();

  Stream<List<UserDetail>> contacts(String uid);
  Future<UserDetail?> findByUid(String uid);
  Future<UserDetail?> save(UserDetail user);
}
