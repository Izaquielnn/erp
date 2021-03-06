import 'package:erp/app/models/contato.dart';
import 'package:erp/app/screens/contatos/edit_contato/contato_view_model.dart';
import 'package:erp/app/shared/components/custom_appbar.dart';
import 'package:erp/app/shared/components/dividers.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/components/styled_form_field.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EditContatoPage extends StatefulWidget {
  const EditContatoPage({Key? key, this.contato, this.nome}) : super(key: key);

  static const String routeName = '/edit_contato';

  final Contato? contato;
  final String? nome;

  @override
  _EditContatoPagePageState createState() => _EditContatoPagePageState();
}

class _EditContatoPagePageState extends State<EditContatoPage> {
  late ContatoViewModel contatoViewModel;
  @override
  void initState() {
    contatoViewModel = ContatoViewModel(contato: widget.contato);
    if (widget.contato == null && widget.nome != null) {
      contatoViewModel.nomeController.text = widget.nome ?? '';
    }
    contatoViewModel.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: contatoViewModel.scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: CustomColors.white,
        appBar: CustomAppBar(
          icon: IconButton(
            onPressed: () {
              Modular.to.pop<Contato?>(contatoViewModel.contato);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CustomColors.primary,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.contato == null
                      ? 'Adicionar contato'
                      : 'Editar contato',
                  style: TextStyles.T1.textColor(CustomColors.primary),
                ),
              ),
              contatoViewModel.loading
                  ? CircularProgressIndicator()
                  : CustomButton.primary(
                      text: 'Salvar',
                      onTap: () => contatoViewModel.saveContato(context),
                      icon: Icon(
                        Icons.check,
                        color: CustomColors.white,
                      ),
                    ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Form(
                    key: contatoViewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledFormField(
                          textEditingController:
                              contatoViewModel.nomeController,
                          labelText: 'Nome',
                          hintText: 'Nome ou fantasia',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return 'M??nimo 3 caracteres';
                            }
                            return null;
                          },
                        ),
                        Dividers.dividerSimple,
                        ...contatoViewModel.contatosControllers.entries
                            .map((entry) => Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: StyledFormField(
                                    textEditingController: entry.key,
                                    labelText: 'N??mero do celular',
                                    realtimeValidation: true,
                                    validator: (value) {
                                      if (value != null &&
                                          value.isNotEmpty &&
                                          value.length != 15) {
                                        return 'N??mero inv??lido';
                                      }
                                      return null;
                                    },
                                    fillColor: CustomColors.secondary,
                                    masks: [entry.value],
                                    suffixIcon: GestureDetector(
                                      onTap: () => contatoViewModel
                                          .removeContatoInput(entry.key),
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
                        CustomButton.secondary(
                          text: ' Add n??mero',
                          onTap: contatoViewModel.addContatoInput,
                          icon: ImageIcon(
                            StyledIcons.add,
                            size: 14,
                            color: CustomColors.primaryVariant,
                          ),
                        ),
                        Dividers.dividerGroup,
                        StyledFormField(
                          textEditingController:
                              contatoViewModel.cpfCnpjController,
                          labelText: contatoViewModel.cpf_cnpj.value,
                          realtimeValidation: true,
                          validator: (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                !(value.length == 14 || value.length == 18)) {
                              return 'CPF ou CNPJ inv??lidos';
                            }
                            return null;
                          },
                          fillColor: CustomColors.secondary,
                          masks: [contatoViewModel.cpfCnpjMask],
                        ),
                        Dividers.dividerSimple,
                        if (contatoViewModel.cpf_cnpj == CPF_CNPJ.CNPJ) ...[
                          StyledFormField(
                            textEditingController:
                                contatoViewModel.razaSocialController,
                            labelText: 'Raz??o social',
                            fillColor: CustomColors.secondary,
                            borderRadius: Corners.s10Border,
                            realtimeValidation: true,
                            validator: (value) {
                              if (value == null || value.length < 3) {
                                return 'M??nimo 3 caracteres';
                              }
                              return null;
                            },
                          ),
                          Dividers.dividerSimple,
                          StyledFormField(
                            textEditingController:
                                contatoViewModel.inscEstadualController,
                            labelText: 'Insc. Estadual',
                            fillColor: CustomColors.secondary,
                            borderRadius: Corners.s10Border,
                            realtimeValidation: true,
                            masks: [contatoViewModel.insEstadualMask],
                            validator: (value) {
                              if (value != null &&
                                  value.isNotEmpty &&
                                  value.length != 12) {
                                return 'Inscri????o Estadual inv??lida';
                              }
                              return null;
                            },
                          ),
                        ],
                        Dividers.dividerGroup,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: StyledFormField(
                                textEditingController:
                                    contatoViewModel.cepController,
                                labelText: 'CEP',
                                fillColor: CustomColors.secondary,
                                borderRadius: Corners.s10Border,
                                realtimeValidation: true,
                                masks: [contatoViewModel.cepMask],
                                validator: (value) {
                                  if (value != null &&
                                      value.isNotEmpty &&
                                      value.length != 9) {
                                    return 'cep inv??lido';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Dividers.dividerVertical,
                            Expanded(
                              child: StyledFormField(
                                textEditingController:
                                    contatoViewModel.cidadeController,
                                labelText: 'Cidade',
                                fillColor: CustomColors.secondary,
                                borderRadius: Corners.s10Border,
                              ),
                            ),
                          ],
                        ),
                        Dividers.dividerSimpleTiny,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: StyledFormField(
                                textEditingController:
                                    contatoViewModel.logradouroController,
                                labelText: 'Logradouro',
                                fillColor: CustomColors.secondary,
                                borderRadius: Corners.s10Border,
                              ),
                            ),
                            Dividers.dividerVertical,
                            SizedBox(
                              width: 80,
                              child: StyledFormField(
                                textEditingController:
                                    contatoViewModel.numeroController,
                                labelText: 'N??mero',
                                fillColor: CustomColors.secondary,
                                borderRadius: Corners.s10Border,
                              ),
                            ),
                          ],
                        ),
                        Dividers.dividerSimpleTiny,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: StyledFormField(
                                textEditingController:
                                    contatoViewModel.bairroController,
                                labelText: 'Bairro',
                                fillColor: CustomColors.secondary,
                                borderRadius: Corners.s10Border,
                              ),
                            ),
                            Dividers.dividerVertical,
                            SizedBox(
                              width: 80,
                              child: StyledFormField(
                                textEditingController:
                                    contatoViewModel.ufController,
                                labelText: 'UF',
                                fillColor: CustomColors.secondary,
                                borderRadius: Corners.s10Border,
                              ),
                            ),
                          ],
                        ),
                        Dividers.dividerSimpleTiny,
                        StyledFormField(
                          textEditingController:
                              contatoViewModel.complementoController,
                          labelText: 'Complemento',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                        ),
                        Dividers.dividerGroup,
                        StyledFormField(
                          textEditingController:
                              contatoViewModel.emailController,
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
      ),
    );
  }
}
