import 'package:flutter/material.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/widgets/text_feiled_container.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/cubit/login_cubit.dart';
import 'package:shop_app_app/modules/shop_app/shop_register/cubit/register_cubit.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';

var passwordRegisterContrller = TextEditingController();
// var formKey = GlobalKey<FormState>();

class RoundedPassworRegisterdField extends StatelessWidget {
  // final ValueChanged<String> onChanged;
  const RoundedPassworRegisterdField(

      )
      : super();

  @override
  Widget build(BuildContext context) {
    return TextFeiledContainer(
        child: defaultFormField(
      controller: passwordRegisterContrller,
      type: TextInputType.visiblePassword,
      validate: (String value) {
        if (value.isEmpty) {
          return (' Your password is too short');
        }
      },
      label: 'Password ',
      isPassword: ShopRegisterCubit.get(context).ispassword,
      prefix: Icons.lock,
      suffixpressed: () {
        ShopRegisterCubit.get(context).ChangePasswordRegisterVisibility();
      },
      suffix: ShopRegisterCubit.get(context).suffix,
      // iconcolor: kPrimaryColor,
      onSubmit: (value) {
        //print('ولاء');
        // if (formKey.currentState!.validate()) {
        //   ShopLoginCubit.get(context).userLogin(
        //       email: emailContrller.text, password: passwordContrller.text);
        // }
      },
    ));
    //TextFeiledContainer(
    //   child: TextFormField(
    //       keyboardType: TextInputType.visiblePassword,
    //       obscureText: true,
    //       onChanged: onChanged,
    //       decoration: InputDecoration(
    //         hintText: 'Password',
    //         icon: Icon(
    //           Icons.lock,
    //           color: kPrimaryColor,
    //         ),
    //         suffixIcon: Icon(
    //           Icons.visibility,
    //           color: kPrimaryColor,
    //         ),
    //         border: InputBorder.none,
    //       )),
    // );
  }
}
