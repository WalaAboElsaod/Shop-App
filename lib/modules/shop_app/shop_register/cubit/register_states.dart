import 'package:shop_app_app/model/shop_app/login_model.dart';
import 'package:shop_app_app/model/shop_app/shop_user_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  final ShopUserModel shopUserModel;
  ShopRegisterSuccessState(this.shopUserModel);
}

class ShopRegisterErrorsState extends ShopRegisterState {
  final String error;

  ShopRegisterErrorsState(this.error);
}

class ShopRegisterPasswordVisibilityState extends ShopRegisterState {}
