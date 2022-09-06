import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Favorites_model/favorites_model.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/shop_model/shop_login_model.dart';
import 'package:shop_app/modules/cateogries/cateogries_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/cubit_shop_app/states_shop_app.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(shopInitialeState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int cuurentIndex = 0;
  List<Widget> bootomScreen = [
    ProductsScreen(),
    CateogriesScreen(),
    favoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    cuurentIndex = index;
    emit(shopChangeBottomNavState());
  }

  late HomeModel homeModel;
  late Map<int, bool> favorites = {};
  void getHomeData() {
    emit(shopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data!.banners[0].image);
      print(homeModel.status);
      //هيلف يتاكد فيه فافوريت ولا لا ويملي
      homeModel.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorite,
        });
      });

      emit(shopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorHomeDataState());
    });
  }

  late CategoriesModel categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(shopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorCategoriesState());
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int product_id) {
    //عشان تنور وتطفي لحظيا
    favorites[product_id] = !favorites[product_id]!;
    emit(shopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': product_id,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel.status) {
        favorites[product_id] = !favorites[product_id]!;
      } else {
        getFavorites();
      }
      emit(shopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((eror) {
      favorites[product_id] = !favorites[product_id]!;
      emit(shopErrorChangeFavoritesState());
    });
  }

  late FavoritesModel favoritesModel;
  void getFavorites() {
    emit(shopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(shopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorGetFavoritesState());
    });
  }

  late ShopLoginModel userModel;
  void getUserData() {
    emit(shopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel.data!.name);
      emit(shopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(shopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATEPROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel.data!.name);
      emit(shopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorUpdateUserState());
    });
  }
}
