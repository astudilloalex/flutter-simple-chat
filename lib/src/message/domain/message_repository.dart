import 'package:simple_chat/src/message/domain/message.dart';

abstract class IMessageRepository {
  const IMessageRepository();

  Stream<Message?> getLastMessage(String currentUID, String otherUID);
  Stream<List<Message>> getUserMessages(String uid);
}
