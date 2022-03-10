import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  Widget? icon;
  Widget title;
  CustomAppBar({required this.title, this.icon})
      : super(child: title, preferredSize: AppBar().preferredSize);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(right: 16, left: 10),
      child: Row(children: [
        icon ?? SizedBox(),
        Expanded(child: title),
      ]),
    );
  }
}
