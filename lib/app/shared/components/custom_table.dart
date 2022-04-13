import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomItem<T> {
  String columnName;
  Widget Function(T) columnBuilder;
  int flex;
  FlexFit fit;
  CustomItem({
    required this.columnName,
    required this.columnBuilder,
    this.flex = 1,
    this.fit = FlexFit.tight,
  });
}

class CustomTable<T> extends StatelessWidget {
  const CustomTable({
    Key? key,
    required this.items,
    required this.columns,
  }) : super(key: key);

  final List<T> items;
  final List<CustomItem<T>> columns;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          buildHeader(),
          buildItens(),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        children: columns
            .map(
              (column) => Flexible(
                fit: column.fit,
                flex: column.flex,
                child: Text(
                  column.columnName,
                  maxLines: 2,
                  style: TextStyles.Body2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildItens() {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          T item = items[index];
          return Container(
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: Corners.s10Border,
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            margin: EdgeInsets.only(top: 5),
            child: Row(
              children: columns
                  .map(
                    (column) => Flexible(
                      flex: column.flex,
                      fit: column.fit,
                      child: column.columnBuilder(item),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
