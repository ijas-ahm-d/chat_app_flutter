import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.appColor,
      title: Text(
        "APP-CHAT",
        style: TextStyles.onText(
          17,
          FontWeight.w700,
          AppColors.kblack,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
          ),
        ),
      ],
    );
  }
}


