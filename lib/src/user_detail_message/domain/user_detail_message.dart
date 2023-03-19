import 'package:simple_chat/src/message/domain/message.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';

class UserDetailMessage {
  const UserDetailMessage({
    required this.message,
    required this.userDetail,
  });

  final Message message;
  final UserDetail userDetail;
}
