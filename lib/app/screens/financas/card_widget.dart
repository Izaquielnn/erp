import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    this.scale = 1,
  }) : super(key: key);

  String title;
  double value;
  Color color;
  double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.H2.textColor(CustomColors.black2),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'R\$',
                  style: TextStyles.H1
                      .size(FontSizes.s18 * scale)
                      .textColor(CustomColors.black2),
                ),
                SizedBox(width: 10),
                Text(
                  value.toStringAsFixed(2),
                  style: TextStyles.H1
                      .size(FontSizes.s36 * scale)
                      .textColor(color),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
