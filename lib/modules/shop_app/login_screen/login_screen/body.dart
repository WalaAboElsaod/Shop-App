import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/login_screen/background.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/cubit/login_cubit.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/widgets/rounded_password.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/widgets/rounded_text_field.dart';
import 'package:shop_app_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app_app/layout/shop_layout.dart';
import 'package:shop_app_app/modules/shop_app/shop_register/register_screen/shop_register_screen.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';
import 'package:shop_app_app/shared/componants/constants/constants.dart';
import 'package:shop_app_app/shared/network/local/cash_helper.dart';
import 'package:shop_app_app/shared/styles/colors.dart';

import '../cubit/login_states.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              if (state.loginModel.status) {
                print(state.loginModel.message);

                print(state.loginModel.data?.token);

                CashHelper.saveData(
                        key: 'taken', value: state.loginModel.data?.token)
                    .then((value) {
                  taken=state.loginModel.data?.token;
                  navigateAndFinish(context, ShopLayout());
                });
              } else {
                print(state.loginModel.message);

                showToast(
                    text: state.loginModel.message, state: ToastState.ERROR);
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
                    Text('LOGIN',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    // SizedBox(
                    //   height: 30.0,
                    // ),
                    SvgPicture.asset('assets/images/shop1.svg',
                        height: size.height * 0.35),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    RoundedTextField(),
                    RoundedPasswordField(),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (BuildContext context) =>
                            state is! ShopLoginLoadingState,
                        widgetBuilder: (BuildContext context) =>
                            defultTextButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailContrller.text,
                                        password: passwordContrller.text);
                                  }
                                },
                                text: 'LOGIN',
                            ),


                        fallbackBuilder: (BuildContext context) =>
                            Center(child: CircularProgressIndicator())),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(

                          onTap: (){
                            navigateTo(context, OnBoardingScreen());
                          },
                            child: Text(' Don\'t have an account?')),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, ShopRegisterScreen());
                          },
                          child: Text(
                            'Register Now',
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
