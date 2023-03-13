import 'package:simple_chat/src/message/domain/message.dart';

abstract class IMessageRepository {
  const IMessageRepository();

  Stream<List<Message>> get messages;
}
