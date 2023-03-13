import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:simple_chat/ui/pages/home/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(controller.currentUser?.username ?? '');
        }),
        actions: [
          IconButton(
            onPressed: null,
            icon: Obx(() {
              return CircleAvatar(
                backgroundImage: NetworkImage(
                  controller.currentUser?.photoURL ??
                      'https://i.postimg.cc/WzCPwS95/user-circular-avatar.png',
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
