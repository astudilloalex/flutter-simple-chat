import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/src/message/domain/message.dart';
import 'package:simple_chat/src/message/domain/message_repository.dart';

class FirebaseMessageRepository implements IMessageRepository {
  const FirebaseMessageRepository();

  @override
  // TODO: implement messages
  Stream<List<Message>> get messages {
    // User? user = FirebaseAuth.instance.currentUser;
    // FirebaseFirestore.instance.collection('users').doc(user?.uid ?? '').collection('messages');
    throw UnimplementedError();
  }
}
