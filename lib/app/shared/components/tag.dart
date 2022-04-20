import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({Key? key, required this.tagName, required this.tagColor})
      : super(key: key);

  final String tagName;
  final Color tagColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: tagColor,
          borderRadius: Corners.s5Border,
        ),
        child: Text(
          tagName,
          style: TextStyles.Body3.textColor(CustomColors.white).size(10),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
