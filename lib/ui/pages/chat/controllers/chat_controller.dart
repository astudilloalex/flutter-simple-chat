import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat/app/services/get_it_service.dart';
import 'package:simple_chat/src/message/application/message_service.dart';
import 'package:simple_chat/src/message/domain/message.dart';
import 'package:simple_chat/src/message/domain/message_type.dart';
import 'package:simple_chat/src/user_detail/application/user_detail_service.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';

class ChatController extends GetxController {
  ChatController(this.uid);
  final String uid;

  late final String currentUID;
  final UserDetailService _userDetailService = getIt<UserDetailService>();
  final MessageService _messageService = getIt<MessageService>();

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final Rxn<UserDetail> _userDetail = Rxn<UserDetail>();
  final Rx<List<Message>> _messages = Rx<List<Message>>([]);
  final RxBool _canSend = RxBool(false);

  @override
  void onInit() {
    _load();
    super.onInit();
    _userDetail.bindStream(_userDetailService.findById(uid));
    _messages.bindStream(_messageService.getMessages(uid));
    messageController.addListener(() {
      if (messageController.text.trim().isEmpty) {
        if (_canSend.value) _canSend(false);
      } else {
        if (!_canSend.value) _canSend(true);
      }
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> _load() async {
    currentUID = (await _userDetailService.currentUser())?.uid ?? '';
  }

  Future<void> sendMessage() async {
    if (!_canSend.value) return;
    await _messageService.sendMessage(
      Message(
        body: messageController.text.trim(),
        dateTime: DateTime.now(),
        messageType: MessageType.text,
        sentBy: currentUID,
        sentTo: uid,
      ),
    );
    messageController.clear();
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  UserDetail? get userDetail => _userDetail.value;
  List<Message> get messages => _messages.value;
  bool get canSend => _canSend.value;
}
