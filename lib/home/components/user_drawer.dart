import 'package:chat_app/user_auth/view_model/logged_view_model.dart';
import 'package:chat_app/user_auth/view_model/signup_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignupViewModel>();
    final userVal = context.watch<LoggedInViewModel>();
    return Drawer(
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            onDetailsPressed: () {},
            decoration: const BoxDecoration(
              color: AppColors.appColor,
            ),
            accountName: Text(userVal.userName ?? "person"),
            accountEmail: Text(userVal.userEmail ?? "person@gmail.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: AppColors.kblack,
              child: Icon(
                Icons.person,
                size: 35,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.power_settings_new_sharp,
              color: AppColors.hashColor,
            ),
            title: const Text("Log Out"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: AppColors.kwhite,
                    title: Text(
                      "Log Out",
                      style: TextStyles.onText(
                        15,
                        FontWeight.bold,
                        AppColors.kblack,
                      ),
                    ),
                    content: Text(
                      "Are you sure do you want to logout the App?",
                      style: TextStyles.onText(
                        13,
                        FontWeight.w500,
                        AppColors.kblack,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await provider.setLogOutStatus(context);
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: AppColors.spRed,
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
