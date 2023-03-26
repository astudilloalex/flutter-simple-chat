import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/src/message/domain/message.dart';
import 'package:simple_chat/src/message/domain/message_repository.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail_repository.dart';

class MessageService {
  const MessageService(
    this._repository,
    this._userDetailRepository,
  );

  final IMessageRepository _repository;
  final IUserDetailRepository _userDetailRepository;

  Stream<Message?> getLastMessage(String userId) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    return _repository.getLastMessage(uid ?? '', userId);
  }

  Future<void> sendMessage(Message message) {
    return _repository.sendMessage(message);
  }

  Stream<List<Message>> getMessages(
    String uid, {
    Message? lastMessage,
    int? size,
  }) {
    final String? currentUid = FirebaseAuth.instance.currentUser?.uid;
    return _repository.getMessages(currentUid ?? '', uid);
  }

  Future<void> createChat(String uid) async {
    if (await _userDetailRepository.existUser(uid)) {
      final String? currentUid = FirebaseAuth.instance.currentUser?.uid;
      return _repository.createChat(currentUid ?? '', uid);
    }
    throw Exception('user-does-not-exist');
  }
}
