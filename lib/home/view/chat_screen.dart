import 'package:chat_app/home/components/chat/chat_input_field.dart';
import 'package:chat_app/home/components/chat/messages.dart';
import 'package:chat_app/home/model/chat_message.dart';
import 'package:chat_app/home/view/group_info.dart';
import 'package:chat_app/home/view_model/group_view_model.dart';
import 'package:chat_app/home/view_model/home_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_values.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final String groupID;
  final String groupName;

  const ChatScreen({
    super.key,
    required this.groupID,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final pro = context.watch<HomeViewModel>();
    final grpPro = context.watch<GroupViewModel>();
    pro.getChatsandAdmin(groupID);
    grpPro.getMembers(groupID);
    return Scaffold(
      backgroundColor: AppColors.blackBG,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const BackButton(color: AppColors.kwhite),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/group.png"),
            ),
            const SizedBox(width: 20 * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.kwhite,
                  ),
                ),
                Opacity(
                  opacity: 0.64,
                  child: Text(
                    groupID,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.kwhite,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info,
              color: AppColors.kwhite,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupInfo(
                      groupId: groupID,
                      groupName: groupName,
                      adminName: pro.groupAdmin ?? "ADMIN"),
                ),
              );
            },
          ),
          AppSizes.kWidth10,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) =>
                    Message(message: demeChatMessages[index]),
              ),
            ),
          ),
          const ChatInputField(),
        ],
      ),
    );
  }
}
