
import 'package:chat_app/home/view_model/home_view_model.dart';
import 'package:chat_app/home/view_model/search_view_model.dart';
import 'package:chat_app/user_auth/components/common_button.dart';
import 'package:chat_app/user_auth/view_model/logged_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_values.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final searchPro = context.watch<SearchViewModel>();
    final homePro = context.watch<HomeViewModel>();
    final logPro = context.watch<LoggedInViewModel>();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: searchPro.groups!.docs.length,
      itemBuilder: (context, index) {
        final String grpId = searchPro.groups!.docs[index]["groupId"];
        final String grpName = searchPro.groups!.docs[index]["groupName"];
        final String admin = searchPro.groups!.docs[index]["admin"];
        final String usrName = logPro.userName ?? "";
        searchPro.joinedOrNot(usrName, grpId, grpName, context);
        
     
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20 * 0.70,
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(
                  "assets/images/group.png",
                ),
                backgroundColor: AppColors.kblack,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        grpName.toUpperCase(),
                        style: TextStyles.onText(
                          16,
                          FontWeight.w600,
                          AppColors.kblack,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSizes.kHeight10,
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          "Admin: ${homePro.getAdminName(admin)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CommonButton(
                size: const Size(75, 40),
                onTap: () async {
                  // await DatabaseService(uid: user!.uid)
                  //     .groupJoin(grpId, usrName, grpName);
                },
                color: AppColors.spGreen,
                child: const Text("Join"),
              ),
            ],
          ),
        );
      },
    );
  }
}
