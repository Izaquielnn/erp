import 'package:erp/app/models/pedido.dart';
import 'package:flutter/material.dart';

class CustomColors {
  static Color primary = Color(0xFF2683C9);
  static Color primaryVariant = Color(0xFF5D99C6);
  static Color secondary = Color(0xFFF0F5F8);

  static Color error = Color(0xFFDA7C78);
  static Color success = Color(0xFF10AC7D);

  static Color black = Color(0xFF4E555E);
  static Color black2 = Color(0xFF4E555E).withOpacity(.80);
  static Color black3 = Color(0xFF4E555E).withOpacity(.68);

  static Color white = Colors.white;

  static Color fromPedidoStatus(STATUS status) {
    switch (status) {
      case STATUS.EM_ABERTO:
        return Colors.amber;
      case STATUS.CANCELADO:
        return error;
      case STATUS.FINALIZADO:
        return black.withOpacity(.4);
      case STATUS.PREPARADO:
        return primaryVariant;
      case STATUS.ENVIADO:
        return success;
      default:
        return Colors.white;
    }
  }
}
