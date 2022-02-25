import 'package:erp/app/models/contato.dart';
import 'package:erp/app/services/contato_service.dart';
import 'package:erp/app/shared/custom_button.dart';
import 'package:erp/app/shared/custom_colors.dart';
import 'package:erp/app/shared/custom_snack_bar.dart';
import 'package:erp/app/shared/http_response.dart';
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
  TextEditingController nomeController = TextEditingController();
  Map<TextEditingController, MaskTextInputFormatter> contatosControllers = {};
  TextEditingController cpfCnpjController = TextEditingController();
  TextEditingController razaSocialController = TextEditingController();
  TextEditingController inscEstadualController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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

  MaskTextInputFormatter cepMask = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  addContatoInput() {
    MaskTextInputFormatter contatoMask = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    if (contatosControllers.length < 4) {
      setState(() => contatosControllers.putIfAbsent(
          TextEditingController(), () => contatoMask));
    }
  }

  removeContatoInput(TextEditingController input) {
    if (contatosControllers.length == 1) {
      contatosControllers.keys.first.clear();
    } else {
      setState(() => contatosControllers.remove(input));
    }
  }

  @override
  initState() {
    addContatoInput();
    cpfCnpjController.addListener(() {
      String value = cpfCnpjController.text;
      CPF_CNPJ status = CPF_CNPJ.NONE;
      if (value.length == 14) {
        status = CPF_CNPJ.CPF;
      } else if (value.length == 18) {
        status = CPF_CNPJ.CNPJ;
      }
      if (status != cpf_cnpj) {
        cpfCnpjController.value = cpfCnpjMask.updateMask(
            mask: value.length <= 14 ? cpfMask : cnpjMask);
        setState(() => cpf_cnpj = status);
      }
    });
    super.initState();
  }

  bool loading = false;

  saveContato() async {
    if (formKey.currentState!.validate()) {
      setState(() => loading = true);

      if (widget.contato == null) {
        Contato contato = Contato(
          nome: nomeController.text,
          contatos: contatosControllers.keys.map((e) => e.text).toList(),
          email: getValue(emailController),
          cpf: cpf_cnpj == CPF_CNPJ.CPF ? cpfCnpjController.text : null,
          cnpj: cpf_cnpj == CPF_CNPJ.CNPJ ? cpfCnpjController.text : null,
          empresa: Empresa(
            inscEstadual: getValue(inscEstadualController),
            razaoSozial: getValue(razaSocialController),
          ),
          endereco: Endereco(
            cep: getValue(cepController),
            cidade: getValue(cidadeController),
            complemento: getValue(complementoController),
            bairro: getValue(bairroController),
            logradouro: getValue(logradouroController),
            numero: getValue(numeroController),
            uf: getValue(ufController),
          ),
        );
        HttpResponse<Contato> response =
            await contatoService.addContato(contato);

        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(message: response.message, isError: !response.success),
        );

        if (response.success) {
          Modular.to.pop();
        }
      }
      setState(() => loading = false);
    }
  }

  String? getValue(TextEditingController controller) =>
      controller.text.isEmpty ? null : controller.text;

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
                  loading
                      ? CircularProgressIndicator()
                      : CustomButton(
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledFormField(
                        textEditingController: nomeController,
                        labelText: 'Nome',
                        hintText: 'Nome ou fantasia',
                        fillColor: CustomColors.secondary,
                        borderRadius: Corners.s10Border,
                        realtimeValidation: true,
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return 'Mínimo 3 caracteres';
                          }
                          return null;
                        },
                      ),
                      dividerSimple,
                      ...contatosControllers.entries
                          .map((entry) => Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: StyledFormField(
                                  textEditingController: entry.key,
                                  labelText: 'Número do celular',
                                  realtimeValidation: true,
                                  validator: (value) {
                                    if (value != null &&
                                        value.isNotEmpty &&
                                        value.length != 15) {
                                      return 'Número inválido';
                                    }
                                    return null;
                                  },
                                  fillColor: CustomColors.secondary,
                                  masks: [entry.value],
                                  suffixIcon: GestureDetector(
                                    onTap: () => removeContatoInput(entry.key),
                                    child: Center(
                                      widthFactor: 0,
                                      child: ImageIcon(
                                        StyledIcons.delete,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 90,
                        child: CustomButton(
                          text: ' Add número',
                          onTap: addContatoInput,
                          icon: ImageIcon(
                            StyledIcons.add,
                            size: 14,
                            color: CustomColors.black2,
                          ),
                          color: CustomColors.secondary,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          textStyle:
                              TextStyles.Body3.textColor(CustomColors.black2),
                        ),
                      ),
                      dividerGroup,
                      StyledFormField(
                        textEditingController: cpfCnpjController,
                        labelText: cpf_cnpj.value,
                        realtimeValidation: true,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              !(value.length == 14 || value.length == 18)) {
                            return 'CPF ou CNPJ inválidos';
                          }
                          return null;
                        },
                        fillColor: CustomColors.secondary,
                        masks: [cpfCnpjMask],
                      ),
                      dividerSimple,
                      if (cpf_cnpj == CPF_CNPJ.CNPJ) ...[
                        StyledFormField(
                          textEditingController: razaSocialController,
                          labelText: 'Razão social',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return 'Mínimo 3 caracteres';
                            }
                            return null;
                          },
                        ),
                        dividerSimple,
                        StyledFormField(
                          textEditingController: inscEstadualController,
                          labelText: 'Insc. Estadual',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                          masks: [insEstadualMask],
                          validator: (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                value.length != 12) {
                              return 'Inscrição Estadual inválida';
                            }
                            return null;
                          },
                        ),
                      ],
                      dividerGroup,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            child: StyledFormField(
                              textEditingController: cepController,
                              labelText: 'CEP',
                              fillColor: CustomColors.secondary,
                              borderRadius: Corners.s10Border,
                              realtimeValidation: true,
                              masks: [cepMask],
                              validator: (value) {
                                if (value != null &&
                                    value.isNotEmpty &&
                                    value.length != 9) {
                                  return 'cep inválido';
                                }
                                return null;
                              },
                            ),
                          ),
                          dividerVertical,
                          Expanded(
                            child: StyledFormField(
                              textEditingController: cidadeController,
                              labelText: 'Cidade',
                              fillColor: CustomColors.secondary,
                              borderRadius: Corners.s10Border,
                            ),
                          ),
                        ],
                      ),
                      dividerSimpleTiny,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: StyledFormField(
                              textEditingController: logradouroController,
                              labelText: 'Logradouro',
                              fillColor: CustomColors.secondary,
                              borderRadius: Corners.s10Border,
                            ),
                          ),
                          dividerVertical,
                          SizedBox(
                            width: 80,
                            child: StyledFormField(
                              textEditingController: numeroController,
                              labelText: 'Número',
                              fillColor: CustomColors.secondary,
                              borderRadius: Corners.s10Border,
                            ),
                          ),
                        ],
                      ),
                      dividerSimpleTiny,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: StyledFormField(
                              textEditingController: bairroController,
                              labelText: 'Bairro',
                              fillColor: CustomColors.secondary,
                              borderRadius: Corners.s10Border,
                            ),
                          ),
                          dividerVertical,
                          SizedBox(
                            width: 80,
                            child: StyledFormField(
                              textEditingController: ufController,
                              labelText: 'UF',
                              fillColor: CustomColors.secondary,
                              borderRadius: Corners.s10Border,
                            ),
                          ),
                        ],
                      ),
                      dividerSimpleTiny,
                      StyledFormField(
                        textEditingController: complementoController,
                        labelText: 'Complemento',
                        fillColor: CustomColors.secondary,
                        borderRadius: Corners.s10Border,
                      ),
                      dividerGroup,
                      StyledFormField(
                        textEditingController: emailController,
                        labelText: 'Email',
                        fillColor: CustomColors.secondary,
                        borderRadius: Corners.s10Border,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dividerSimple = SizedBox(height: 10);
  Widget dividerGroup = SizedBox(height: 30);
  Widget dividerSimpleTiny = SizedBox(height: 5);
  Widget dividerVertical = SizedBox(width: 5);
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
