import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_chat/src/message/domain/message.dart';
import 'package:simple_chat/src/message/domain/message_repository.dart';

class FirebaseMessageRepository implements IMessageRepository {
  const FirebaseMessageRepository();

  @override
  Stream<Message?> getLastMessage(String currentUID, String otherUID) {
    final CollectionReference<Map<String, dynamic>> chats = FirebaseFirestore
        .instance
        .collection('chats')
        .doc(_getConversationId(currentUID, otherUID))
        .collection('messages');
    return chats
        .orderBy('dateTime', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.isEmpty
          ? null
          : Message.fromJson(snapshot.docs.first.data());
    });
  }

  @override
  Stream<List<Message>> getUserMessages(String uid) {
    final CollectionReference<Map<String, dynamic>> chats =
        FirebaseFirestore.instance.collection('chats');
    chats
        .where('userIds', arrayContains: uid)
        .orderBy('lastMessage.dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {});
    });
    // TODO: implement getUserMessages
    throw UnimplementedError();
  }

  String _getConversationId(String currentUID, String otherUID) {
    return currentUID.hashCode <= otherUID.hashCode
        ? '${currentUID}_$otherUID'
        : '${otherUID}_$currentUID';
  }
}
