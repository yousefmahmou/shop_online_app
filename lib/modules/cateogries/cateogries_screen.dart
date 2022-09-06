import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit_shop_app/cubit_shop_app.dart';
import 'package:shop_app/shared/cubit/cubit_shop_app/states_shop_app.dart';

class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => buildCatItem(
            ShopCubit.get(context).categoriesModel.data.data[index]),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: ShopCubit.get(context).categoriesModel.data.data.length,
      ),
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 80,
              height: 80,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_back_ios,
            ),
          ],
        ),
      );
}
