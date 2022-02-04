import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/login_screen/background.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/login_screen/login_screen.dart';
import 'package:shop_app_app/layout/shop_layout.dart';
import 'package:shop_app_app/modules/shop_app/shop_register/cubit/register_cubit.dart';
import 'package:shop_app_app/modules/shop_app/shop_register/cubit/register_states.dart';
import 'package:shop_app_app/modules/shop_app/shop_register/widgets/rounded_name_text_field.dart';
import 'package:shop_app_app/modules/shop_app/shop_register/widgets/rounded_password_register.dart';
import 'package:shop_app_app/modules/shop_app/shop_register/widgets/rounded_phone_text_field.dart';
import 'package:shop_app_app/modules/shop_app/shop_register/widgets/rounded_register_text_field.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';
import 'package:shop_app_app/shared/componants/constants/constants.dart';
import 'package:shop_app_app/shared/network/local/cash_helper.dart';
import 'package:shop_app_app/shared/styles/colors.dart';

// ignore: must_be_immutable
class BodyRegister extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
          listener: (context, state) {
            if (state is ShopRegisterSuccessState) {
              if (state.shopUserModel.status) {
                print(state.shopUserModel.message);

                print(state.shopUserModel.data?.token);

                CashHelper.saveData(
                        key: 'taken', value: state.shopUserModel.data?.token)
                    .then((value) {
                  taken = state.shopUserModel.data?.token;
                  navigateAndFinish(context, ShopLayout());
                });
              } else {
                print(state.shopUserModel.message);

                showToast(
                    text: state.shopUserModel.message!,
                    state: ToastState.ERROR);
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
                child: Background(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('REGISTER',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    // SizedBox(
                    //   height: 30.0,
                    // ),
                    // SvgPicture.asset('assets/images/shop1.svg',
                    //     height: size.height * 0.35),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    RoundedNameTextField(),
                    RoundedRegisterTextField(),
                    RoundedPassworRegisterdField(),
                    RoundedPhoneTextField(),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (BuildContext context) =>
                            state is! ShopRegisterLoadingState,
                        widgetBuilder: (BuildContext context) =>
                            defultTextButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: nameContrller.text,
                                      phone: phoneContrller.text,
                                      email: emailRegisterContrller.text,
                                      password: passwordRegisterContrller.text);
                                }
                              },
                              text: 'REGISTER NOW ',
                            ),
                        fallbackBuilder: (BuildContext context) =>
                            Center(child: CircularProgressIndicator())),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('l have an account?'),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, LoginShopScreen());
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
