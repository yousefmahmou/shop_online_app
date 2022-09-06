import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Favorites_model/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit_shop_app/cubit_shop_app.dart';
import 'package:shop_app/shared/cubit/cubit_shop_app/states_shop_app.dart';
import 'package:shop_app/shared/styles/colors.dart';

class favoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
          condition: state is! shopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildListProduct(
                    ShopCubit.get(context)
                        .favoritesModel
                        .data!
                        .data[index]
                        .product!,
                    context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount:
                    ShopCubit.get(context).favoritesModel.data!.data.length,
              ),
          fallback: (context) => Center(child: CircularProgressIndicator())),
    );
  }
}
