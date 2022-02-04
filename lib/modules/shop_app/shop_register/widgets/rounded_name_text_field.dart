import 'package:flutter/material.dart';
import 'package:shop_app_app/modules/shop_app/login_screen/widgets/text_feiled_container.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';

var nameContrller = TextEditingController();

class RoundedNameTextField extends StatelessWidget {
  const RoundedNameTextField() : super();

  @override
  Widget build(BuildContext context) {
    return TextFeiledContainer(
        child: defaultFormField(
      controller: nameContrller,
      type: TextInputType.text,
      validate: (String? value) {
        if (value!.isEmpty) {
          return (' Please enter your name');
        }
      },
      onChange: (String? value) {
        print(value);
      },
      label: 'Name',

      prefix: Icons.person,
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
