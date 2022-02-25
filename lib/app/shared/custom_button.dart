import 'package:erp/app/shared/custom_colors.dart';
import 'package:erp/app/shared/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.borderRadius,
    this.textStyle,
    this.color,
    this.padding,
    this.icon,
  }) : super(key: key);

  String text;
  void Function() onTap;
  BorderRadius? borderRadius;
  TextStyle? textStyle;
  Color? color;
  EdgeInsets? padding;

  Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? CustomColors.primary,
          borderRadius: borderRadius ?? Corners.sCircularBorder,
        ),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            icon ?? SizedBox(),
            Center(
              child: Text(
                text,
                style: textStyle ?? TextStyles.H1.textColor(CustomColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
