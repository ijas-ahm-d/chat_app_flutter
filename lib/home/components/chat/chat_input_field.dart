import 'package:chat_app/utils/global_colors.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        // color: Theme.of(context).scaffoldBackgroundColor,
        color: AppColors.blackBG,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(
              Icons.mic,
              color: AppColors.appColor,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20 * 0.75,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(25, 107, 99, 255),
                  // color: AppColors.appColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: AppColors.kwhite.withOpacity(0.64),
                    ),
                    const SizedBox(width: 20 / 4),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          hintStyle: TextStyle(color: AppColors.kwhite),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: AppColors.kwhite.withOpacity(0.64),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
