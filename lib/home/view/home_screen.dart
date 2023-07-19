import 'package:chat_app/home/components/no_data_found.dart';
import 'package:chat_app/home/components/user_app_bar.dart';
import 'package:chat_app/home/components/user_drawer.dart';
import 'package:chat_app/home/components/user_floating_button.dart';
import 'package:chat_app/user_auth/view_model/logged_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_values.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userVal = context.watch<LoggedInViewModel>();
    final size = MediaQuery.of(context).size;
    userVal.getUserDetails();
    return Scaffold(
        backgroundColor: AppColors.kwhite,
        drawer: const UserDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.07),
          child: const UserAppBar(),
        ),
        body: StreamBuilder(
          stream: userVal.groups,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data['groups'] != null) {
                if (snapshot.data["groups"].length != 0) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => AppSizes.kHeight10,
                    itemCount: snapshot.data["groups"].length,
                    itemBuilder: (context, index) {
                      int reverseIndex =
                          snapshot.data["groups"].length - index - 1;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        color: Colors.green,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.appColor,
                            child: Text(
                              getName(
                                snapshot.data["groups"][reverseIndex],
                              ).substring(0, 1).toUpperCase(),
                            ),
                          ),
                          title: Text(
                            getName(
                              snapshot.data["groups"][reverseIndex],
                            ),
                          ),
                          subtitle: Text(
                            getId(
                              snapshot.data["groups"][reverseIndex],
                            ),
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
                ),
              );
            }
          },
        ),
        floatingActionButton: UserFloatingButton());
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }
}
