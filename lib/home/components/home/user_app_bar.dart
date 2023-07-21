

import 'package:chat_app/home/view_model/home_view_model.dart';
import 'package:chat_app/home/view_model/search_view_model.dart';

import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAppBar extends StatelessWidget {
  final String? title;
  const UserAppBar({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final pro = context.watch<HomeViewModel>();
    final search = context.watch<SearchViewModel>();
  
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 10,
            backgroundImage: AssetImage(
              "assets/images/male.png",
            ),
          ),
        ),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.appColor,
      title: Text(
        title ?? "TEAM-TALK",
        style: TextStyles.onText(
          17,
          FontWeight.w700,
          AppColors.kwhite,
        ),
      ),
      actions: [
     
        pro.isSearch
            ? IconButton(
                splashRadius: 1,
                onPressed: () {
                  pro.setSearch();
                  search.setuserSearched(false);
                  pro.clearController();
                },
                icon: const Icon(
                  Icons.cancel,
                  color: AppColors.kwhite,
                ),
              )
            : IconButton(
                splashRadius: 1,
                onPressed: () {
                  pro.setSearch();
                },
                icon: const Icon(
                  Icons.search,
                  color: AppColors.kwhite,
                ),
              ),
      ],
    );
  }
}
