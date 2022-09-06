import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout/shop_layout_screen.dart';
import 'package:shop_app/modules/bloc_observer/bloc_observer.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/on_boarding/onboarding_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/cubit/cubit_login/cubit_shop_login.dart';
import 'package:shop_app/shared/cubit/cubit_login/states_shop_login.dart';
import 'package:shop_app/shared/cubit/cubit_shop_app/cubit_shop_app.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init;
  await Cachehelper.init();
  bool? isDark = Cachehelper.getData(key: 'isDark');
  Widget widget;

  bool onBoarding = Cachehelper.getData(key: 'onBoarding');
  token = Cachehelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark!,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            // themeMode:ShopLoginCubit.get(context).isDark? ThemeMode.dark: ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
