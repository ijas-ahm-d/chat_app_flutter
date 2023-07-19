import 'package:chat_app/utils/global_colors.dart';
import 'package:flutter/material.dart';

class CommonSnackBAr {
  static snackBar({
    required BuildContext context,
    required String data,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          data,
          style: const TextStyle(
            color: AppColors.kblack,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        padding: const EdgeInsets.all(15),
        elevation: 6,
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        clipBehavior: Clip.hardEdge,
        dismissDirection: DismissDirection.horizontal,
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      ),
    );
  }
}
