import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_values.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/add.png"),
          AppSizes.kHeight10,
          Text(
            "You've not joined in any groups, tap on the add icon to create a group or also search from top search button.",
            textAlign: TextAlign.center,
            style: TextStyles.onText(
              13,
              FontWeight.w600,
              AppColors.kblack,
            ),
          )
        ],
      ),
    );
  }
}
