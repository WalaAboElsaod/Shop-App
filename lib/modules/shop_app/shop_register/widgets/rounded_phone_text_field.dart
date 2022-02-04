import 'package:flutter/material.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/widgets/text_feiled_container.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';

var phoneContrller = TextEditingController();

class RoundedPhoneTextField extends StatelessWidget {
  const RoundedPhoneTextField() : super();

  @override
  Widget build(BuildContext context) {
    return TextFeiledContainer(
        child: defaultFormField(
      controller: phoneContrller,
      type: TextInputType.phone,
      validate: (String? value) {
        if (value!.isEmpty) {
          return (' Please enter your phone');
        }
      },
      onChange: (String? value) {
        print(value);
      },
      label: 'Phone',

      prefix: Icons.phone,
      // iconcolor: kPrimaryColor,
      onSubmit: (String value) {
        print(value);
      },
    ));

    // TextFormField(
    //   keyboardType: TextInputType.emailAddress,

    //   onFieldSubmitted: submit;
    //   validator: validate ,
    //         onChanged: onChanged

    //   },
    //   decoration: InputDecoration(
    //       icon: Icon(
    //         icon,
    //         color: kPrimaryColor,
    //       ),
    //       hintText: ' Your email',
    //       border: InputBorder.none),
    // ));
  }
}
