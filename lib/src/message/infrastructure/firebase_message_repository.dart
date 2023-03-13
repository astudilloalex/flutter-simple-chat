import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/src/message/domain/message.dart';
import 'package:simple_chat/src/message/domain/message_repository.dart';

class FirebaseMessageRepository implements IMessageRepository {
  const FirebaseMessageRepository();

  @override
  Stream<List<Message>> getUserMessages(String uid) {
    final CollectionReference<Map<String, dynamic>> chats =
        FirebaseFirestore.instance.collection('chats');
    chats
        .where('userIds', arrayContains: uid)
        .orderBy('lastMessage.dateTime')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {});
    });
    // TODO: implement getUserMessages
    throw UnimplementedError();
  }
}
