import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_chat/src/message/domain/message.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';
import 'package:simple_chat/src/user_detail_message/domain/user_detail_message.dart';
import 'package:simple_chat/src/user_detail_message/domain/user_detail_message_repository.dart';

class FirebaseUserDetailMessageRepository
    implements IUserDetailMessageRepository {
  const FirebaseUserDetailMessageRepository();

  @override
  Stream<List<UserDetailMessage>> findAll(
    String uid, {
    UserDetailMessage? lastElement,
    int? size,
  }) {
    final CollectionReference<Map<String, dynamic>> chatCollection =
        FirebaseFirestore.instance.collection('chats');
    final CollectionReference<Map<String, dynamic>> userCollection =
        FirebaseFirestore.instance.collection('users');
    return chatCollection
        .where('userIds', arrayContains: uid)
        .orderBy('lastMessage.dateTime', descending: true)
        .snapshots()
        .map((chatSnapshot) {
      return chatSnapshot.docs.map((chatDoc) {
        final Stream<Message> message = Stream.value(chatDoc).map<Message>(
          (document) => Message.fromJson(
            document.data()['lastMessage'] as Map<String, dynamic>,
          ),
        );
        final List<dynamic> users = chatDoc.data()['userIds'] as List<dynamic>;
        final Stream<UserDetail> user = userCollection
            .doc(
              users.firstWhere(
                (element) => element as String != uid,
                orElse: () => uid,
              ) as String,
            )
            .snapshots()
            .map<UserDetail>(
              (document) => UserDetail.fromJson(document.data()!),
            );
        return Rx.combineLatest2(
          message,
          user,
          (a, b) => UserDetailMessage(message: a, userDetail: b),
        );
      });
    }).switchMap(
      (value) {
        final List<Stream<UserDetailMessage>> streams = value.toList();
        print(Rx.combineLatestList(streams));
        return streams.isNotEmpty
            ? Rx.combineLatestList(streams)
            : Stream.value([]);
      },
    );
  }
}
