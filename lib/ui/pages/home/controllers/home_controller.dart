import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat/app/services/get_it_service.dart';
import 'package:simple_chat/src/auth/application/authenticator.dart';
import 'package:simple_chat/src/message/application/message_service.dart';
import 'package:simple_chat/src/user_detail/application/user_detail_service.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';
import 'package:simple_chat/src/user_detail_message/application/user_detail_message_service.dart';
import 'package:simple_chat/src/user_detail_message/domain/user_detail_message.dart';

class HomeController extends GetxController {
  final UserDetailService _userDetailService = getIt<UserDetailService>();
  final UserDetailMessageService _userDetailMessageService =
      getIt<UserDetailMessageService>();
  final Authenticator _authenticator = getIt<Authenticator>();
  final MessageService _messageService = getIt<MessageService>();

  final TextEditingController userIdController = TextEditingController();

  final Rxn<UserDetail> _currentUser = Rxn<UserDetail>();
  final RxBool _addingContact = RxBool(false);

  @override
  void onClose() {
    userIdController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    _currentUser(await _userDetailService.currentUser());
  }

  Future<String?> addContact() async {
    final String uid = userIdController.text.trim();
    if (uid.isEmpty) return 'user-does-not-exist';
    try {
      _addingContact(true);
      await _messageService.createChat(uid);
    } on Exception catch (ex) {
      return ex.toString();
    } finally {
      _addingContact(false);
      userIdController.clear();
    }
    return null;
  }

  Future<void> logout() => _authenticator.logout();

  UserDetail? get currentUser => _currentUser.value;

  Stream<List<UserDetailMessage>> get contacts =>
      _userDetailMessageService.getLastMessages();

  bool get addingContact => _addingContact.value;
}
