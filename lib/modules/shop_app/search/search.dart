// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/search/states/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchsScreen extends StatelessWidget {
  const SearchsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  defaultFormFaild(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'enter text to search';
                      }
                      return null;
                    },
                    onsubmet: (String text) {
                      SearchCubit.get(context).Search(text);
                    },
                    Label: 'Search',
                    prefix: Icons.search,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is SearchSuccessState)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildIteamProducts(
                          SearchCubit.get(context).model!.data!.data![index],
                          context,
                          isOldPrice: false),
                      separatorBuilder: (context, index) => MyDivider(),
                      itemCount:
                          SearchCubit.get(context).model!.data!.data!.length,
                    ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
