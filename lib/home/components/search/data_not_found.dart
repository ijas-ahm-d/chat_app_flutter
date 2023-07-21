import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_values.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/noData.png"),
        Center(
          child: Text(
            "No Groups Found",
            style: TextStyles.onText(
              15,
              FontWeight.bold,
              AppColors.kblack,
            ),
          ),
        ),
        AppSizes.kHeight10,
        const Center(
          child: Text(
            "You can create a new group",
          ),
        ),
      ],
    );
  }
}
