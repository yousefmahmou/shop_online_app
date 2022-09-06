import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/cubit_search/states_shop_search.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchState> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;
  void search(String text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}
