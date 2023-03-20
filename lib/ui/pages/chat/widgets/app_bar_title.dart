import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';
import 'package:simple_chat/ui/pages/chat/controllers/chat_controller.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find<ChatController>();
    return Obx(() {
      if (controller.userDetail == null) {
        return const Text('');
      }
      return _ListTileTitle(userDetail: controller.userDetail!);
    });
  }
}

class _ListTileTitle extends StatelessWidget {
  const _ListTileTitle({required this.userDetail});

  final UserDetail userDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.adaptive.arrow_back),
                if (userDetail.photoURL != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(userDetail.photoURL!),
                  ),
                if (userDetail.photoURL == null)
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://i.postimg.cc/WzCPwS95/user-circular-avatar.png',
                    ),
                    radius: 18.0,
                  ),
              ],
            ),
          ),
          onTap: () {
            context.pop();
          },
        ),
        Expanded(
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userDetail.username),
                ],
              ),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
