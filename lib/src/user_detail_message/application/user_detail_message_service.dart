import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/src/user_detail_message/domain/user_detail_message.dart';
import 'package:simple_chat/src/user_detail_message/domain/user_detail_message_repository.dart';

class UserDetailMessageService {
  const UserDetailMessageService(this._repository);

  final IUserDetailMessageRepository _repository;

  Stream<List<UserDetailMessage>> getLastMessages() {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    return _repository.findAll(uid ?? 'test');
  }
}
