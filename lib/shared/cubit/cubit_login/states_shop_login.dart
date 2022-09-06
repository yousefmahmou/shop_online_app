import 'package:shop_app/models/shop_model/shop_login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  late final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginState {}
