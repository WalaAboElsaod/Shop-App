import 'package:flutter/material.dart';
import 'package:shop_app_app/shared/styles/colors.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Function pressed;
  final Color color, textColor;
  const RoundedButton({
    this.text,
    required this.pressed,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          onPressed: () {
            pressed();
          },
          child: Text(
            text!,
            style: TextStyle(color: Colors.white),
          ),
          color: color,
        ),
      ),
    );
  }
}
