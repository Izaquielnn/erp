import 'package:flutter/material.dart';

class StyledIcons {
  static AssetImage get edit => AssetImage('assets/icons/edit.png');
  static AssetImage get add => AssetImage('assets/icons/add.png');
  static AssetImage get delete => AssetImage('assets/icons/delete.png');
  static AssetImage get label => AssetImage('assets/icons/label.png');
  static AssetImage get search => AssetImage('assets/icons/search.png');
  static AssetImage get trash => AssetImage('assets/icons/trash.png');
  static AssetImage get user => AssetImage('assets/icons/user.png');
  static AssetImage get industry => AssetImage('assets/icons/industry.png');
  static AssetImage get phone => AssetImage('assets/icons/phone.png');
  static AssetImage get robotConfuse =>
      AssetImage('assets/icons/robot_confuse.png');
  static Image whats(double size) => Image(
        image: AssetImage('assets/icons/whats.png'),
        width: size,
        height: size,
        color: null,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
      );
}
