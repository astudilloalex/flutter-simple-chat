import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat/ui/pages/chat/controllers/chat_controller.dart';
import 'package:simple_chat/ui/theme/app_theme_colors.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find<ChatController>();
    final AppThemeColor color = Theme.of(context).extension<AppThemeColor>()!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.messageController,
              smartDashesType: SmartDashesType.enabled,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                isDense: true,
              ),
            ),
          ),
          Obx(() {
            if (!controller.canSend) {
              return const SizedBox.shrink();
            }
            return InkResponse(
              onTap: controller.sendMessage,
              radius: 25.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: 55.0,
                    color: color.primary,
                  ),
                  const Icon(Icons.send),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
