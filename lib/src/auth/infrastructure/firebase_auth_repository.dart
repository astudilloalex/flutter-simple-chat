import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_chat/src/auth/domain/auth_repository.dart';

class FirebaseAuthRepository implements IAuthRepository {
  const FirebaseAuthRepository();

  @override
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }

  @override
  // TODO: implement currentUser
  Future<User?> get currentUser async => FirebaseAuth.instance.currentUser;

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
