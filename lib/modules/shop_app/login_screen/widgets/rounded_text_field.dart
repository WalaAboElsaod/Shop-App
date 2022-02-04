import 'package:flutter/material.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/widgets/text_feiled_container.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';

var emailContrller = TextEditingController();

class RoundedTextField extends StatelessWidget {
  const RoundedTextField() : super();

  @override
  Widget build(BuildContext context) {
    return TextFeiledContainer(
        child: defaultFormField(
      controller: emailContrller,
      type: TextInputType.emailAddress,
      validate: (String? value) {
        if (value!.isEmpty) {
          return (' Please enter your email address');
        }
      },
      onChange: (String? value) {
        print(value);
      },
      label: 'Email address',

      prefix: Icons.email_outlined,
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
