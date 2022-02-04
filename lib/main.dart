import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_app/shared/bloc_observer.dart';
import 'package:shop_app_app/shared/network/local/cash_helper.dart';
import 'package:shop_app_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app_app/shared/styles/themes.dart';

import 'modules/shop_app/cubit/cubit.dart';
import 'modules/shop_app/login_screen/login_screen/login_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'layout/shop_layout.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CashHelper.init();
  Widget widget = LoginShopScreen();
   bool? onBoarding = CashHelper.getData(key: 'onBoarding');
  dynamic taken = CashHelper.getData(key: 'taken');
  print (taken);
  // ignore: unnecessary_null_comparison
  if (onBoarding != null) {
    if (taken != null) {
      widget = ShopLayout();
    } else {
      widget = LoginShopScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  print(onBoarding);
  runApp(MyApp(
    startWidget: widget,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  late Widget startWidget;
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return


        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..geFavoritesData()..getUserData(),

        child:MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,

            home:
            startWidget,


        )

    );
  }
}
