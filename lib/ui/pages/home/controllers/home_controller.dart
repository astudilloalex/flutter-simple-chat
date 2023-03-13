import 'package:get/get.dart';
import 'package:simple_chat/app/services/get_it_service.dart';
import 'package:simple_chat/src/user_detail/application/user_detail_service.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';

class HomeController extends GetxController {
  final UserDetailService _userDetailService = getIt<UserDetailService>();

  final Rxn<UserDetail> _currentUser = Rxn<UserDetail>();

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    _currentUser(await _userDetailService.currentUser());
  }

  UserDetail? get currentUser => _currentUser.value;
}
