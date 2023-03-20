import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_chat/src/message/domain/message.dart';
import 'package:simple_chat/ui/theme/app_theme_colors.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.isMe});

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final AppThemeColor color = Theme.of(context).extension<AppThemeColor>()!;
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: size.width * 0.90),
          decoration: BoxDecoration(
            color: !isMe ? Colors.grey[300] : color.primary.withOpacity(0.75),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: !isMe ? Radius.zero : const Radius.circular(12),
              bottomRight: isMe ? Radius.zero : const Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.body,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('HH:mm').format(message.dateTime),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
