import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_chat/ui/pages/chat/controllers/chat_controller.dart';
import 'package:simple_chat/ui/pages/chat/widgets/app_bar_title.dart';
import 'package:simple_chat/ui/pages/chat/widgets/chat_list.dart';
import 'package:simple_chat/ui/pages/chat/widgets/message_input.dart';
import 'package:simple_chat/ui/widgets/google_ads/google_banner_ad.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.uid});
  final String uid;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    Get.put<ChatController>(ChatController(widget.uid));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ChatController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: const AppBarTitle(),
      ),
      body: SafeArea(
        child: Column(
          children: const [
            GoogleBannerAd(),
            Expanded(child: ChatList()),
            MessageInput(),
          ],
        ),
      ),
    );
  }
}
