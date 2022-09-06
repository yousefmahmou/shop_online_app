import 'package:shop_app/models/shop_model/shop_login_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  late final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterState {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterState {}
