import 'package:simple_chat/src/user_detail_message/domain/user_detail_message.dart';

abstract class IUserDetailMessageRepository {
  const IUserDetailMessageRepository();

  Stream<List<UserDetailMessage>> findAll(
    String uid, {
    UserDetailMessage? lastElement,
    int? size,
  });
}
