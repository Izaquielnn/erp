import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({Key? key, required String message, bool isError = false})
      : super(
          key: key,
          duration: Durations.slow,
          backgroundColor: isError ? CustomColors.error : CustomColors.success,
          content: Text(
            message,
            maxLines: 2,
            style: TextStyles.H1.textColor(CustomColors.white),
            textAlign: TextAlign.center,
          ),
        );
}
