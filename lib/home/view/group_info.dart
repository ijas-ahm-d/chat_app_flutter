import 'package:chat_app/home/view_model/group_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupInfo extends StatelessWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfo(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.adminName});

  @override
  Widget build(BuildContext context) {
    final pro = context.watch<GroupViewModel>();
    final admin = pro.getName(adminName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        centerTitle: true,
        leading: const BackButton(color: AppColors.kwhite),
        title: const Text(
          "Group Info",
          style: TextStyle(
            color: AppColors.kwhite,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.appColor.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/male.png"),
                      backgroundColor: AppColors.appColor,
                    ),
                    AppSizes.kWidth20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Group: $groupName"),
                        AppSizes.kHeight5,
                        Text("Admin: $admin"),
                      ],
                    )
                  ],
                ),
              ),
              StreamBuilder(
                stream: pro.members,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data["members"] != null) {
                      if (snapshot.data["members"].length != 0) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data["members"].length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage("assets/images/male.png"),
                                  backgroundColor: AppColors.appColor,
                                ),
                                title: Text(
                                  pro.getName(
                                    snapshot.data["members"][index],
                                  ),
                                ),
                                subtitle: Text(
                                  pro.getId(
                                    snapshot.data["members"][index],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("No Members"),
                        );
                      }
                    } else {
                      return const Center(
                        child: Text("No Members"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
