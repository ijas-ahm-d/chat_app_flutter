import 'package:chat_app/home/view_model/home_view_model.dart';
import 'package:chat_app/user_auth/components/text_form_field.dart';
import 'package:chat_app/user_auth/view_model/logged_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_values.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFloatingButton extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  UserFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<LoggedInViewModel>();
    final pro = Provider.of<HomeViewModel>(context,listen: false);
    final size = MediaQuery.of(context).size;
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            backgroundColor: AppColors.kwhite,
            children: [
              SimpleDialogOption(
                child: Text(
                  "CREATE GROUP",
                  textAlign: TextAlign.center,
                  style: TextStyles.onText(
                    15,
                    FontWeight.w800,
                    AppColors.kblack,
                  ),
                ),
              ),
              AppSizes.kHeight10,
              Consumer<HomeViewModel>(
                builder: (context, value, child) {
                  return SimpleDialogOption(
                    child: Form(
                      key: _formkey,
                      child: TextFormWidget(
                        prefixIcon: const Icon(Icons.group_add),
                        controller: pro.groupNameController,
                        hintText: "Group Name",
                        keyType: TextInputType.name,
                        size: size,
                        isGroup: true,
                      ),
                    ),
                  );
                },
              ),
              AppSizes.kHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyles.onText(
                        15,
                        FontWeight.bold,
                        AppColors.kblack,
                      ),
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      pro.createGroup(context,user.userName??"");
                    },
                    child: Text(
                      "Create",
                      style: TextStyles.onText(
                        15,
                        FontWeight.bold,
                        AppColors.kblack,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      backgroundColor: AppColors.appColor,
      elevation: 0,
      autofocus: true,
      child: const Icon(Icons.add),
    );
  }

  createGroup(BuildContext context, size, groupController) {
  
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        backgroundColor: AppColors.kwhite,
        children: [
          SimpleDialogOption(
            child: Text(
              "CREATE GROUP",
              textAlign: TextAlign.center,
              style: TextStyles.onText(
                15,
                FontWeight.w800,
                AppColors.kblack,
              ),
            ),
          ),
          AppSizes.kHeight10,
          Consumer<HomeViewModel>(
            builder: (context, value, child) {
              return SimpleDialogOption(
                child: Form(
                  key: _formkey,
                  child: TextFormWidget(
                    prefixIcon: const Icon(Icons.group_add),
                    controller: groupController,
                    hintText: "Group Name",
                    keyType: TextInputType.name,
                    size: size,
                    isGroup: true,
                  ),
                ),
              );
            },
          ),
          AppSizes.kHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyles.onText(
                    15,
                    FontWeight.bold,
                    AppColors.kblack,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child: Text(
                  "Create",
                  style: TextStyles.onText(
                    15,
                    FontWeight.bold,
                    AppColors.kblack,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
