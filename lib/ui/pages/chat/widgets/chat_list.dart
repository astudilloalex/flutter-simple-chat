import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_chat/src/message/domain/message.dart';
import 'package:simple_chat/ui/pages/chat/controllers/chat_controller.dart';
import 'package:simple_chat/ui/pages/chat/widgets/chat_bubble.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find<ChatController>();
    return Obx(() {
      final DateTime date = DateTime.now();
      return ListView.builder(
        itemCount: controller.messages.length,
        controller: controller.scrollController,
        reverse: true,
        itemBuilder: (context, index) {
          final Message message = controller.messages[index];
          final Message? nextMessage = index < controller.messages.length - 1
              ? controller.messages[index + 1]
              : null;
          final bool showDate = nextMessage == null ||
              !_sameDate(message.dateTime, nextMessage.dateTime);
          return Column(
            children: [
              if (showDate)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      _sameDate(message.dateTime, date)
                          ? 'Today'
                          : DateFormat('MMMM dd, yyyy')
                              .format(message.dateTime),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ChatBubble(
                message: message,
                isMe: message.sentBy == controller.currentUID,
              ),
            ],
          );
        },
      );
    });
  }

  bool _sameDate(DateTime date, DateTime secondDate) {
    return date.year == secondDate.year &&
        date.month == secondDate.month &&
        date.day == secondDate.day;
  }
}
