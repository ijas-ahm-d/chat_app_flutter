import 'package:chat_app/home/model/chat_message.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,
      padding: const EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.appColor.withOpacity(1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message!.text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
