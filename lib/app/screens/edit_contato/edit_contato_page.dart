import 'package:erp/app/models/contato.dart';
import 'package:erp/app/services/contato_service.dart';
import 'package:erp/app/shared/custom_button.dart';
import 'package:erp/app/shared/custom_colors.dart';
import 'package:erp/app/shared/custom_snack_bar.dart';
import 'package:erp/app/shared/styled_form_field.dart';
import 'package:erp/app/shared/styled_icons.dart';
import 'package:erp/app/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditContatoPage extends StatefulWidget {
  const EditContatoPage({Key? key, this.contato}) : super(key: key);

  static const String routeName = '/edit_contato';

  final Contato? contato;

  @override
  _EditContatoPagePageState createState() => _EditContatoPagePageState();
}

class _EditContatoPagePageState extends State<EditContatoPage> {
  ContatoService contatoService = Modular.get();
  final formKey = GlobalKey<FormState>();
  TextEditingController cpfController = TextEditingController();
  TextEditingController inscEstadualController = TextEditingController();

  MaskTextInputFormatter cpfCnpjMask = MaskTextInputFormatter(
    mask: '###.###.###-####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  String cpfMask = '###.###.###-#####';
  String cnpjMask = '##.###.###/####-##';
  CPF_CNPJ cpf_cnpj = CPF_CNPJ.NONE;

  MaskTextInputFormatter insEstadualMask = MaskTextInputFormatter(
    mask: '##.###.###-#',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  bool loading = false;

  @override
  initState() {
    cpfController.addListener(() {
      String value = cpfController.text;
      CPF_CNPJ status = CPF_CNPJ.NONE;
      if (value.length == 14) {
        status = CPF_CNPJ.CPF;
      } else if (value.length == 18) {
        status = CPF_CNPJ.CNPJ;
      }
      if (status != cpf_cnpj) {
        cpfController.value = cpfCnpjMask.updateMask(
            mask: value.length <= 14 ? cpfMask : cnpjMask);
        setState(() => cpf_cnpj = status);
      }
    });
    super.initState();
  }

  saveContato() async {
    formKey.currentState!.validate();
    print(cpfController.text);
    // setState(() => loading = true);
    // List<Contato>? editedContato = await contatoService.getContatos();
    // if (editedContato == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     CustomSnackBar(
    //         message:
    //             'Não foi possível buscar os contatos. Tente novamente mais tarde!',
    //         isError: true),
    //   );
    // }
    // setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: CustomColors.primary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.contato == null
                          ? 'Adicionar contato'
                          : 'Editar contato',
                      style: TextStyles.T1.textColor(CustomColors.primary),
                    ),
                  ),
                  CustomButton(
                    text: 'Salvar',
                    onTap: saveContato,
                    icon: Icon(
                      Icons.check,
                      color: CustomColors.white,
                    ),
                    padding: EdgeInsets.only(right: 5),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  StyledFormField(
                    textEditingController: TextEditingController(),
                    labelText: 'Nome',
                    fillColor: CustomColors.secondary,
                    borderRadius: Corners.s10Border,
                    validator: (value) {
                      if (value == null || value.length < 3) {
                        return 'Mínimo 3 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  StyledFormField(
                    textEditingController: cpfController,
                    labelText: cpf_cnpj.value,
                    autorrect: false,
                    validator: (value) {
                      if (value == null ||
                          !(value.length == 14 || value.length == 18)) {
                        return 'CPF ou CNPJ inválidos';
                      }
                      return null;
                    },
                    fillColor: CustomColors.secondary,
                    masks: [cpfCnpjMask],
                  ),
                  SizedBox(height: 10),
                  if (cpf_cnpj == CPF_CNPJ.CNPJ) ...[
                    StyledFormField(
                      textEditingController: TextEditingController(),
                      labelText: 'Razão social',
                      fillColor: CustomColors.secondary,
                      borderRadius: Corners.s10Border,
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return 'Mínimo 3 caracteres';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    StyledFormField(
                      textEditingController: inscEstadualController,
                      labelText: 'Insc. Estadual',
                      fillColor: CustomColors.secondary,
                      borderRadius: Corners.s10Border,
                      masks: [insEstadualMask],
                      validator: (value) {
                        if (value == null || value.length != 12) {
                          return 'Inscrição Estadual inválida';
                        }
                        return null;
                      },
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum CPF_CNPJ { CPF, CNPJ, NONE }

extension ValueExtension on CPF_CNPJ {
  String get value {
    switch (this) {
      case CPF_CNPJ.NONE:
        return 'CPF / CNPJ';
      case CPF_CNPJ.CPF:
        return 'CPF';
      case CPF_CNPJ.CNPJ:
        return 'CNPJ';
      default:
        return 'CPF / CNPJ';
    }
  }
}
