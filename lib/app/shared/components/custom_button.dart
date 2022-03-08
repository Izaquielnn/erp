import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.textStyle,
    required this.color,
    required this.padding,
    this.icon,
  }) : super(key: key);

  String text;
  void Function() onTap;
  TextStyle textStyle;
  Color color;
  EdgeInsets padding;

  Widget? icon;

  CustomButton.primary({
    required this.text,
    required this.onTap,
    this.icon,
  })  : this.textStyle = TextStyles.H1.textColor(CustomColors.white),
        this.color = CustomColors.primary,
        padding = EdgeInsets.symmetric(horizontal: 2);

  CustomButton.secondary({
    required this.text,
    required this.onTap,
    this.icon,
  })  : this.textStyle = TextStyles.H1.textColor(CustomColors.primaryVariant),
        this.color = CustomColors.secondary,
        padding = EdgeInsets.symmetric(horizontal: 5, vertical: 4);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.sCircularBorder,
          color: color,
        ),
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon ?? SizedBox(), SizedBox(width: 5)],
            Text(
              text,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
