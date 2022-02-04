import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_app/model/shop_app/login_model.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/cubit/login_states.dart';
import 'package:shop_app_app/shared/network/end_points.dart';
import 'package:shop_app_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJason(value.data);
      print(loginModel.status);

      print(loginModel.message);
      // print(loginModel.data!.token);

      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print('هالايرور  ${error.toString()}');
      emit(ShopLoginErrorsState(error));
    });
  }

  bool ispassword = true;
  IconData suffix = Icons.visibility;
  // ignore: non_constant_identifier_names
  void ChangePasswordVisibility() {
    ispassword = !ispassword;

    suffix = ispassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ShopLoginPasswordVisibilityState());
  }
}
