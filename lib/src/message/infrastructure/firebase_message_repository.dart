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
  Stream<List<Message>> getMessages(
    String uid,
    String otherUID, {
    Message? lastMessage,
    int? size,
  }) {
    final CollectionReference<Map<String, dynamic>> chats = FirebaseFirestore
        .instance
        .collection('chats')
        .doc(_getConversationId(uid, otherUID))
        .collection('messages');
    if (size != null) {
      if (lastMessage != null) {
        return chats
            .orderBy('dateTime', descending: true)
            .startAfter([lastMessage.dateTime])
            .limit(size)
            .snapshots()
            .map(
              (snapshot) => snapshot.docs
                  .map((doc) => Message.fromJson(doc.data()))
                  .toList(),
            );
      }
      return chats
          .orderBy('dateTime', descending: true)
          .limit(size)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => Message.fromJson(doc.data()))
                .toList(),
          );
    }
    return chats.orderBy('dateTime', descending: true).snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList(),
        );
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

  @override
  Future<void> sendMessage(Message message) {
    final DocumentReference<Map<String, dynamic>> chats = FirebaseFirestore
        .instance
        .collection('chats')
        .doc(_getConversationId(message.sentBy, message.sentTo));
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    batch.set(chats.collection('messages').doc(), message.toJson());
    batch.update(
      chats,
      {
        'lastMessage': message.toJson(),
        'userIds': [message.sentBy, message.sentTo]
      },
    );
    return batch.commit();
  }

  String _getConversationId(String currentUID, String otherUID) {
    return currentUID.hashCode <= otherUID.hashCode
        ? '$currentUID-$otherUID'
        : '$otherUID-$currentUID';
  }
}
