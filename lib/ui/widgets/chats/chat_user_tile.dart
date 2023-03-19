import 'package:flutter/material.dart';
import 'package:simple_chat/src/user_detail_message/domain/user_detail_message.dart';

class ChatUserTile extends StatelessWidget {
  const ChatUserTile({
    super.key,
    required this.userDetailMessage,
  });

  final UserDetailMessage userDetailMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: userDetailMessage.userDetail.photoURL != null &&
                userDetailMessage.userDetail.photoURL!.length > 2
            ? CircleAvatar(
                backgroundImage:
                    NetworkImage(userDetailMessage.userDetail.photoURL!),
              )
            : const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.postimg.cc/WzCPwS95/user-circular-avatar.png',
                ),
              ),
        title: Text(
          userDetailMessage.userDetail.username,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          userDetailMessage.message.body,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {},
      ),
    );
  }
}
