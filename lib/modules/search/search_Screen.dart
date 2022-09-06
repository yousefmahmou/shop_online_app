// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit_search/cubit_shop_search.dart';
import 'package:shop_app/shared/cubit/cubit_search/states_shop_search.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onsubmit: (String text) {
                      ShopSearchCubit.get(context).search(text);
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is ShopSearchLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(
                          ShopSearchCubit.get(context).model.data!.data[index],
                          context,
                          isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: ShopSearchCubit.get(context)
                            .model
                            .data!
                            .data
                            .length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
