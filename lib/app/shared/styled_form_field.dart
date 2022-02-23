import 'package:erp/app/shared/custom_colors.dart';
import 'package:erp/app/shared/styles.dart';
import 'package:flutter/material.dart';

class StyledFormField extends StatelessWidget {
  const StyledFormField({
    Key? key,
    required this.textEditingController,
    this.validator,
    this.hintText,
    required this.labelText,
    this.obscureText = false,
    this.prefixIcon,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: textEditingController,
      validator: validator ?? defaultValidator,
      style: TextStyles.H1,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: Corners.s10Border,
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: Corners.s10Border,
          borderSide: BorderSide(color: CustomColors.error),
        ),
        errorStyle: TextStyles.Body3.textColor(CustomColors.error),
        hintText: hintText,
        filled: true,
        labelText: labelText,
        fillColor: CustomColors.white,
        prefixIcon: prefixIcon,
      ),
    );
  }

  String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo não pode ser vazio';
    }
    return null;
  }
}
