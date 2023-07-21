import 'package:chat_app/home/view_model/search_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBars extends StatelessWidget {
  const SearchBars({super.key});

  @override
  Widget build(BuildContext context) {
    final pro = context.watch<SearchViewModel>();



    return Container(
      color: AppColors.appColor,
      height: 90,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 25,
      ),
      child: TextFormField(
        controller: pro.searchController,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          pro.getSearchResult();
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          suffix: IconButton(
            onPressed: () {
              pro.getSearchResult();
            },
            icon: const Icon(
              Icons.send,
              size: 20,
            ),
          ),
          hintText: " Search Group..",
          fillColor: AppColors.kwhite,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.kblack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
