import 'package:chat_app/home/components/home/group_list.dart';
import 'package:chat_app/home/components/home/search_bar.dart';
import 'package:chat_app/home/components/home/user_app_bar.dart';
import 'package:chat_app/home/components/home/user_drawer.dart';
import 'package:chat_app/home/components/home/user_floating_button.dart';
import 'package:chat_app/home/components/search/data_not_found.dart';
import 'package:chat_app/home/components/search/search_results.dart';
import 'package:chat_app/home/view_model/home_view_model.dart';
import 'package:chat_app/home/view_model/search_view_model.dart';
import 'package:chat_app/user_auth/view_model/logged_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchPro = context.watch<SearchViewModel>();
    final pro = context.watch<HomeViewModel>();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            pro.isSearch ? const SearchBars() : const SizedBox(),
            pro.isSearch
                ? searchPro.searchController.text.isEmpty
                    ? const GroupList()
                    : searchPro.isUserSearched
                        ? searchPro.groups!.docs.isEmpty
                            ? const DataNotFound()
                            : const SearchResults()
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                : const GroupList()
          ],
        ),
      ),
      floatingActionButton: UserFloatingButton(),
    );
  }

 
  
}

