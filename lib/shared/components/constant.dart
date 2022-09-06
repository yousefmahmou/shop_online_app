import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void signOut(context) {
  Cachehelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndfinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final Pattern = RegExp('.{1,800}');
  Pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
