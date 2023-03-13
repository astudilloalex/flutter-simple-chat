import 'package:get/get.dart';
import 'package:simple_chat/app/services/get_it_service.dart';
import 'package:simple_chat/src/auth/application/authenticator.dart';

class SignInController extends GetxController {
  final Authenticator _authenticator = getIt<Authenticator>();

  final RxBool _loading = RxBool(false);

  Future<String?> signInWithGoogle() async {
    try {
      _loading(true);
      if ((await _authenticator.signInWithGoogle()) == null) {
        return 'authentication-error';
      }
    } on Exception catch (e) {
      return e.toString();
    } finally {
      _loading(false);
    }
    return null;
  }

  bool get loading => _loading.value;
}
