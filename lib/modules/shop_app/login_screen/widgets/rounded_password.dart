import 'package:flutter/material.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/widgets/text_feiled_container.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/cubit/login_cubit.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';

var passwordContrller = TextEditingController();
// var formKey = GlobalKey<FormState>();

class RoundedPasswordField extends StatelessWidget {
  // final ValueChanged<String> onChanged;
  const RoundedPasswordField(
      //Key? key,
      // required this.onChanged,
      // required Function validate,
      // required TextEditingController controller,
      )
      : super();

  @override
  Widget build(BuildContext context) {
    return TextFeiledContainer(
        child: defaultFormField(
      controller: passwordContrller,
      type: TextInputType.visiblePassword,
      validate: (String value) {
        if (value.isEmpty) {
          return (' Your password is too short');
        }
      },
      label: 'Password ',
      isPassword: ShopLoginCubit.get(context).ispassword,
      prefix: Icons.lock,
      suffixpressed: () {
        ShopLoginCubit.get(context).ChangePasswordVisibility();
      },
      suffix: ShopLoginCubit.get(context).suffix,
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
