import 'package:get/get.dart';
import 'package:simple_chat/app/services/get_it_service.dart';
import 'package:simple_chat/src/auth/application/auth_handler.dart';

class SplashController extends GetxController {
  final AuthHandler _authHandler = getIt<AuthHandler>();

  final RxBool _loading = RxBool(true);
  final RxBool _userLogged = RxBool(false);
  final RxnString _error = RxnString();

  @override
  void onInit() {
    super.onInit();
    verifyAuth();
  }

  Future<void> verifyAuth() async {
    try {
      if ((await _authHandler.currentUser) != null) {
        _userLogged(true);
      } else {
        _userLogged(false);
      }
    } on Exception catch (ex) {
      _error(ex.toString());
    } finally {
      _loading(false);
    }
  }

  bool get loading => _loading.value;
  bool get userLogged => _userLogged.value;
  String? get error => _error.value;
}
