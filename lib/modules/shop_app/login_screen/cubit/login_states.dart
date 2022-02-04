import 'package:shop_app_app/model/shop_app/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorsState extends ShopLoginState {
  final String error;

  ShopLoginErrorsState(this.error);
}

class ShopLoginPasswordVisibilityState extends ShopLoginState {}
