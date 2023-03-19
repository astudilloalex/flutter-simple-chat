import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail.dart';
import 'package:simple_chat/src/user_detail_message/domain/user_detail_message.dart';
import 'package:simple_chat/ui/pages/home/controllers/home_controller.dart';
import 'package:simple_chat/ui/pages/home/widgets/add_contact_dialog.dart';
import 'package:simple_chat/ui/widgets/chats/chat_user_tile.dart';

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
      body: StreamBuilder<List<UserDetailMessage>>(
        stream: controller.contacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return ChatUserTile(
                userDetailMessage: snapshot.data![index],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AddContactDialog();
      },
    );
  }
}
