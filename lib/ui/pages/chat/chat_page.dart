import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_chat/ui/pages/chat/controllers/chat_controller.dart';
import 'package:simple_chat/ui/pages/chat/widgets/app_bar_title.dart';
import 'package:simple_chat/ui/pages/chat/widgets/chat_list.dart';
import 'package:simple_chat/ui/pages/chat/widgets/message_input.dart';
import 'package:simple_chat/ui/widgets/google_ads/google_banner_ad.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    Get.put<ChatController>(ChatController(uid));
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: const AppBarTitle(),
      ),
      body: SafeArea(
        child: Column(
          children: const [
            GoogleBannerAd(adSize: AdSize.fullBanner),
            Expanded(child: ChatList()),
            MessageInput(),
          ],
        ),
      ),
    );
  }
}
