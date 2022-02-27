import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
}
