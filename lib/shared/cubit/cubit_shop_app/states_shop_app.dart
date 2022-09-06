import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shop_app/models/shop_model/shop_login_model.dart';
import 'package:shop_app/shared/cubit/cubit_login/cubit_shop_login.dart';

abstract class ShopStates {}

class shopInitialeState extends ShopStates {}

class shopChangeBottomNavState extends ShopStates {}

class shopLoadingHomeDataState extends ShopStates {}

class shopSuccessHomeDataState extends ShopStates {}

class shopErrorHomeDataState extends ShopStates {}

class shopSuccessCategoriesState extends ShopStates {}

class shopErrorCategoriesState extends ShopStates {}

class shopChangeFavoritesState extends ShopStates {}

class shopSuccessChangeFavoritesState extends ShopStates {
  late final ChangeFavoritesModel model;
  shopSuccessChangeFavoritesState(this.model);
}

class shopErrorChangeFavoritesState extends ShopStates {}

class shopLoadingGetFavoritesState extends ShopStates {}

class shopSuccessGetFavoritesState extends ShopStates {}

class shopErrorGetFavoritesState extends ShopStates {}

class shopLoadingUserDataState extends ShopStates {}

class shopSuccessUserDataState extends ShopStates {
  final ShopLoginModel loginModel;
  shopSuccessUserDataState(this.loginModel);
}

class shopErrorUserDataState extends ShopStates {}

class shopLoadingUpdateUserState extends ShopStates {}

class shopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel;
  shopSuccessUpdateUserState(this.loginModel);
}

class shopErrorUpdateUserState extends ShopStates {}
