import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StyledFormField extends StatelessWidget {
  const StyledFormField({
    Key? key,
    required this.textEditingController,
    this.validator,
    this.hintText,
    required this.labelText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.borderRadius,
    this.masks,
    this.autorrect = true,
    this.realtimeValidation = false,
    this.readOnly = false,
    this.onChanged,
    this.textColor,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final List<TextInputFormatter>? masks;
  final bool autorrect;
  final bool realtimeValidation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      readOnly: readOnly,
      obscureText: obscureText,
      controller: textEditingController,
      validator: validator,
      style: TextStyles.H1.textColor(textColor ?? CustomColors.black),
      inputFormatters: masks,
      autocorrect: autorrect,
      autovalidateMode: realtimeValidation
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: borderRadius ?? Corners.s10Border,
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: Corners.s10Border,
          borderSide:
              BorderSide(color: CustomColors.error.withOpacity(.3), width: .5),
        ),
        hoverColor: (fillColor ?? CustomColors.white).darken(),
        errorStyle: TextStyles.Body3.textColor(CustomColors.error),
        hintText: hintText,
        hintStyle: TextStyles.H1.textColor(CustomColors.black3),
        filled: true,
        labelText: labelText,
        fillColor: fillColor ?? CustomColors.white,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo n??o pode ser vazio';
    }
    return null;
  }
}
