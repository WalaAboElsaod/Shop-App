

import 'package:shop_app_app/modules/shop_app/login_screen/login_screen/login_screen.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';
import 'package:shop_app_app/shared/network/local/cash_helper.dart';

void signOut(context) {
  CashHelper.removeData(key: 'taken').then((value) {
    if (value) {
      navigateAndFinish(context, LoginShopScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

var taken =
CashHelper.getData(key: 'taken');
