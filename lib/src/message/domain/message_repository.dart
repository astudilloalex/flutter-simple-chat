import 'package:simple_chat/src/message/domain/message.dart';

abstract class IMessageRepository {
  const IMessageRepository();

  Stream<Message?> getLastMessage(String currentUID, String otherUID);
  Stream<List<Message>> getMessages(
    String uid,
    String otherUID, {
    Message? lastMessage,
    int? size,
  });
  Stream<List<Message>> getUserMessages(String uid);
  Future<void> sendMessage(Message message);
}
