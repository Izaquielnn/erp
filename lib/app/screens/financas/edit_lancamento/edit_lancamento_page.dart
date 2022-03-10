import 'package:erp/app/models/contato.dart';
import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/screens/contatos/edit_contato/edit_contato_page.dart';
import 'package:erp/app/screens/financas/edit_lancamento/lancamento_view_model.dart';
import 'package:erp/app/services/contato_service.dart';
import 'package:erp/app/shared/components/custom_dropdown.dart';
import 'package:erp/app/shared/components/dividers.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/components/styled_form_field.dart';
import 'package:erp/app/shared/styles/masks.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/shared/utils/dates.dart';
import 'package:erp/app/stores/contato_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class EditLancamentoPage extends StatefulWidget {
  const EditLancamentoPage({Key? key, this.lancamento}) : super(key: key);

  static const String routeName = '/edit_lancamento';

  final Lancamento? lancamento;

  @override
  _EditLancamentoPagePageState createState() => _EditLancamentoPagePageState();
}

class _EditLancamentoPagePageState extends State<EditLancamentoPage> {
  late LancamentoViewModel lancamentoViewModel;
  ContatoService contatoService = Modular.get();
  @override
  void initState() {
    lancamentoViewModel = LancamentoViewModel(lancamento: widget.lancamento);
    lancamentoViewModel.addListener(() => setState(() {}));
    super.initState();
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
                      widget.lancamento == null
                          ? 'Adicionar lançamento'
                          : 'Editar lançamento',
                      style: TextStyles.T1.textColor(CustomColors.primary),
                    ),
                  ),
                  lancamentoViewModel.loading
                      ? CircularProgressIndicator()
                      : CustomButton.primary(
                          text: 'Salvar',
                          onTap: () => lancamentoViewModel.save(context),
                          icon: Icon(
                            Icons.check,
                            color: CustomColors.white,
                          ),
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
                  key: lancamentoViewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledFormField(
                        textEditingController:
                            lancamentoViewModel.descricaoCtrl,
                        labelText: 'Descrição',
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
                      Dividers.dividerSimple,
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropDown(
                              itens: lancamentoViewModel.tipos,
                              onTap: (tipo) {
                                if (tipo == Tipo.ENTRADA.value) {
                                  lancamentoViewModel.tipo.value = Tipo.ENTRADA;
                                } else {
                                  lancamentoViewModel.tipo.value = Tipo.SAIDA;
                                }
                                lancamentoViewModel.tipoCtrl.text = tipo;
                              },
                              child: StyledFormField(
                                readOnly: true,
                                textEditingController:
                                    lancamentoViewModel.tipoCtrl,
                                labelText: 'Tipo',
                                fillColor: CustomColors.secondary,
                                borderRadius: Corners.s10Border,
                                realtimeValidation: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Escolha uma tipo';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Dividers.dividerVertical,
                          Expanded(
                            child: ValueListenableBuilder<Tipo>(
                              valueListenable: lancamentoViewModel.tipo,
                              builder: (context, tipo, child) =>
                                  StyledFormField(
                                textColor: tipo == Tipo.ENTRADA
                                    ? CustomColors.success
                                    : CustomColors.error,
                                textEditingController:
                                    lancamentoViewModel.valorCtrl,
                                labelText: 'Valor',
                                fillColor: CustomColors.secondary,
                                borderRadius: Corners.s10Border,
                                realtimeValidation: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Adicione um valor';
                                  }
                                  return null;
                                },
                                masks: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  Masks.precoMask()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Dividers.dividerGroup,
                      CustomDropDown(
                        itens: lancamentoViewModel.contas.value,
                        onTap: (unidade) {
                          lancamentoViewModel.contaCtrl.text = unidade;
                        },
                        child: StyledFormField(
                          readOnly: true,
                          textEditingController: lancamentoViewModel.contaCtrl,
                          labelText: 'Conta',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Escolha uma conta';
                            }
                            return null;
                          },
                        ),
                      ),
                      Dividers.dividerSimple,
                      CustomDropDown(
                        itens: lancamentoViewModel.categorias.value,
                        onTap: (unidade) {
                          lancamentoViewModel.categoriaCtrl.text = unidade;
                        },
                        child: StyledFormField(
                          readOnly: true,
                          textEditingController:
                              lancamentoViewModel.categoriaCtrl,
                          labelText: 'Centro de custos',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Escolha uma categoria';
                            }
                            return null;
                          },
                        ),
                      ),
                      Dividers.dividerGroup,
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: AbsorbPointer(
                                child: StyledFormField(
                                  readOnly: true,
                                  textEditingController:
                                      lancamentoViewModel.dateCtrl,
                                  labelText: 'Data',
                                  fillColor: CustomColors.secondary,
                                  borderRadius: Corners.s10Border,
                                  realtimeValidation: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Escolha uma data';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime.now(),
                                  helpText: "",
                                ).then((d) {
                                  if (d != null) {
                                    lancamentoViewModel.date = d;
                                    lancamentoViewModel.dateCtrl.text =
                                        Dates.format(d);
                                  }
                                });
                              },
                            ),
                          ),
                          Dividers.dividerVertical,
                          Expanded(
                            child: GestureDetector(
                              child: AbsorbPointer(
                                child: StyledFormField(
                                  readOnly: true,
                                  textEditingController:
                                      lancamentoViewModel.competenciaCtrl,
                                  labelText: 'Competência',
                                  fillColor: CustomColors.secondary,
                                  borderRadius: Corners.s10Border,
                                  realtimeValidation: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Escolha uma data';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime.now(),
                                  helpText: "",
                                ).then((d) {
                                  if (d != null) {
                                    lancamentoViewModel.competenciaDate = d;
                                    lancamentoViewModel.competenciaCtrl.text =
                                        Dates.format(d);
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Dividers.dividerGroup,
                      Column(
                        children: [
                          TypeAheadFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              onChanged: (v) {
                                lancamentoViewModel.contato.value = null;
                                lancamentoViewModel.contato.notifyListeners();
                              },
                              controller: lancamentoViewModel.contatoCtrl,
                              style: TextStyles.H1,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderRadius: Corners.s10Border,
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: Corners.s10Border,
                                  borderSide: BorderSide(
                                      color: CustomColors.error.withOpacity(.3),
                                      width: .5),
                                ),
                                hoverColor: CustomColors.secondary.darken(),
                                errorStyle: TextStyles.Body3.textColor(
                                    CustomColors.error),
                                hintText: '',
                                hintStyle: TextStyles.H1
                                    .textColor(CustomColors.black3),
                                filled: true,
                                labelText: 'Cliente ou fornecedor',
                                fillColor: CustomColors.secondary,
                                prefixIcon: Center(
                                  widthFactor: 1,
                                  child: ImageIcon(
                                    StyledIcons.user,
                                    color: CustomColors.primary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                              borderRadius: Corners.s10Border,
                            ),
                            suggestionsCallback: contatoService.searchContatos,
                            itemBuilder: (context, Contato contato) {
                              String phone = contato.contatos.isNotEmpty
                                  ? contato.contatos.first
                                  : '';
                              return ListTile(
                                dense: true,
                                title: Text(
                                  contato.nome,
                                  style: TextStyles.Body1,
                                ),
                                subtitle: Text(
                                  contato.cpf ?? contato.cnpj ?? phone,
                                  style: TextStyles.Body3.textColor(
                                      CustomColors.black3),
                                ),
                              );
                            },
                            onSuggestionSelected: (Contato value) {
                              lancamentoViewModel.contato.value = value;
                              lancamentoViewModel.contatoCtrl.text = value.nome;
                            },
                          ),
                        ],
                      ),
                      ValueListenableBuilder(
                          valueListenable: lancamentoViewModel.contato,
                          builder: (context, contato, _) {
                            if (contato == null &&
                                lancamentoViewModel
                                    .contatoCtrl.text.isNotEmpty) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Será criado um novo contato',
                                      style: TextStyles.Body3,
                                    ),
                                    CustomButton.secondary(
                                      text: 'completar dados',
                                      onTap: () {
                                        Modular.to.pushNamed(
                                            EditContatoPage.routeName,
                                            arguments: lancamentoViewModel
                                                .contatoCtrl.text);
                                      },
                                      icon: ImageIcon(
                                        StyledIcons.edit,
                                        color: CustomColors.primaryVariant,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container();
                          }),
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
}
