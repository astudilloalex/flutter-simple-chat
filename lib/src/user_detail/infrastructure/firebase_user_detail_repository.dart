import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail_repository.dart';

class FirebaseUserDetailRepository implements IUserDetailRepository {
  const FirebaseUserDetailRepository();

  @override
  Stream<List<UserDetail>> contacts(String uid) {
    final CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('users');
    final Stream<List<String>> data = collection
        .doc(uid)
        .collection('contacts')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => e.id).toList());
    Stream<List<UserDetail>> users;
    data.listen((event) {
      users = collection.where('uid', whereIn: event).snapshots().map(
            (snapshot) => snapshot.docs
                .map((e) => UserDetail.fromJson(e.data()))
                .toList(),
          );
    });
    return users;
  }

  @override
  Future<UserDetail?> save(UserDetail user) async {
    final CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('users');
    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await collection.doc(user.uid).get();
    if (userSnapshot.exists) {
      return UserDetail.fromJson(userSnapshot.data()!);
    }
    await collection.doc(user.uid).set(user.toJson());
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await collection.doc(user.uid).get();
    if (doc.data() == null) return null;
    return UserDetail.fromJson(doc.data()!);
  }

  @override
  Future<UserDetail?> findByUid(String uid) async {
    final CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('users');
    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await collection.doc(uid).get();
    if (userSnapshot.data() != null) {
      return UserDetail.fromJson(userSnapshot.data()!);
    }
    return null;
  }
}
