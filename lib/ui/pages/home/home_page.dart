import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat/src/user_detail_message/domain/user_detail_message.dart';
import 'package:simple_chat/ui/pages/home/controllers/home_controller.dart';
import 'package:simple_chat/ui/pages/home/widgets/add_contact_dialog.dart';
import 'package:simple_chat/ui/pages/home/widgets/barcode_view.dart';
import 'package:simple_chat/ui/routes/route_name.dart';
import 'package:simple_chat/ui/widgets/chats/chat_user_tile.dart';
import 'package:simple_chat/ui/widgets/google_ads/google_banner_ad.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Chat'),
        // title: Obx(() {
        //   return Text(controller.currentUser?.username ?? '');
        // }),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 0) {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (context) {
                    return const BarcodeView();
                  },
                );
              }
              if (value == 1) {
                controller.logout();
                context.goNamed(RouteName.signIn);
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Text('My ID'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text(AppLocalizations.of(context)?.logout ?? ''),
                ),
              ];
            },
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
      body: Column(
        children: [
          const GoogleBannerAd(),
          Expanded(
            child: StreamBuilder<List<UserDetailMessage>>(
              stream: controller.contacts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context, HomeController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return const AddContactDialog();
      },
    ).then((value) {
      if (value != null && value is String && value.length > 1) {
        context.pushNamed(
          RouteName.chat,
          params: {'userId': value},
        );
      }
    });
  }
}
