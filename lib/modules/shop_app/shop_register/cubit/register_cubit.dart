import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_app/model/shop_app/login_model.dart';
import 'package:shop_app_app/model/shop_app/shop_user_model.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/cubit/login_states.dart';
import 'package:shop_app_app/modules/shop_app/shop_register/cubit/register_states.dart';
import 'package:shop_app_app/shared/network/end_points.dart';
import 'package:shop_app_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late ShopUserModel shopUserModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {'email': email, 'password': password,' name':  name,' phone':  phone})
        .then((value) {
      print(value.data);
      shopUserModel = ShopUserModel.fromJason(value.data);


      emit(ShopRegisterSuccessState(shopUserModel));
    }).catchError((error) {
      print('هالايرور  ${error.toString()}');
      emit(ShopRegisterErrorsState(error));
    });
  }

  bool ispassword = true;
  IconData suffix = Icons.visibility;
  // ignore: non_constant_identifier_names
  void ChangePasswordRegisterVisibility() {
    ispassword = !ispassword;

    suffix = ispassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ShopRegisterPasswordVisibilityState());
  }
}
