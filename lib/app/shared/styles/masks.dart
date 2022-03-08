import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

class Masks {
  static MaskTextInputFormatter cpfCnpjMask(
          {String text = '', String mask = '###.###.###-####'}) =>
      MaskTextInputFormatter(
        mask: mask,
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
        initialText: text,
      );

  static String cpfMask = '###.###.###-#####';
  static String cnpjMask = '##.###.###/####-##';

  static MaskTextInputFormatter insEstadualMask({String text = ''}) =>
      MaskTextInputFormatter(
        mask: '##.###.###-#',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
        initialText: text,
      );

  static MaskTextInputFormatter cepMask({String text = ''}) =>
      MaskTextInputFormatter(
        mask: '#####-###',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
        initialText: text,
      );

  static MaskTextInputFormatter contatoMask({String text = ''}) =>
      MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
        initialText: text,
      );
  static CurrencyPtBrInputFormatter precoMask() =>
      CurrencyPtBrInputFormatter(maxDigits: 8);
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({required this.maxDigits});
  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    String newText = formatter.format(value / 100);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
