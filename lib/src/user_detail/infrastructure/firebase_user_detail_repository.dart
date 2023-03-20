import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail_repository.dart';

class FirebaseUserDetailRepository implements IUserDetailRepository {
  const FirebaseUserDetailRepository();

  @override
  Future<void> addContact(String uid) {
    final CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
            .collection('contacts');
    return collection.doc(uid).set({});
  }

  @override
  Stream<List<UserDetail>> contacts(String uid) {
    throw UnimplementedError();
  }

  @override
  Future<bool> existUser(String uid) {
    final CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('users');
    return collection.doc(uid).get().then((value) => value.exists);
  }

  @override
  Stream<UserDetail?> findById(String uid) {
    final CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('users');
    return collection.doc(uid).snapshots().map(
          (snapshot) =>
              snapshot.exists ? UserDetail.fromJson(snapshot.data()!) : null,
        );
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
}
