import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/cubit_shop_app/cubit_shop_app.dart';
import 'package:shop_app/shared/cubit/cubit_shop_app/states_shop_app.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is shopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  controller: nameController,
                  type: TextInputType.text,
                  label: 'Name',
                  prefix: Icons.person,
                ),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email',
                  prefix: Icons.email,
                ),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  label: 'Phone',
                  prefix: Icons.phone,
                ),
                SizedBox(
                  height: 20,
                ),
                defaultButton(
                  function: () {
                    ShopCubit.get(context).updateUserData(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                    );
                  },
                  text: 'Update',
                ),
                SizedBox(
                  height: 20,
                ),
                defaultButton(
                  function: () {
                    signOut(context);
                  },
                  text: 'Logout',
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
