
import 'package:chat_app/home/components/home/no_data_found.dart';
import 'package:chat_app/home/view/chat_screen.dart';
import 'package:chat_app/home/view_model/home_view_model.dart';
import 'package:chat_app/user_auth/view_model/logged_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_values.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    final userVal = context.watch<LoggedInViewModel>();
    final pro = context.watch<HomeViewModel>();
    return StreamBuilder(
      stream: userVal.groups,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data["groups"].length != 0) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data["groups"].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data["groups"].length - index - 1;
                  final String groupID = pro.getId(
                    snapshot.data["groups"][reverseIndex],
                  );
                  final String groupName = pro.getGroupName(
                    snapshot.data["groups"][reverseIndex],
                  );

                  return InkWell(
                    onTap: () {
                   
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatScreen(
                              groupID: groupID,
                              groupName: groupName,
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    groupName.toUpperCase(),
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
                                      groupID,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Opacity(
                            opacity: 0.64,
                            child: Text("08:10 AM"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const NoDataFound();
            }
          } else {
            return const NoDataFound();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.spGreen,
            ),
          );
        }
      },
    );
  }
}
