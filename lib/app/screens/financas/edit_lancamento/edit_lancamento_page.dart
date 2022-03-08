import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/screens/financas/edit_lancamento/lancamento_view_model.dart';
import 'package:erp/app/shared/components/custom_dropdown.dart';
import 'package:erp/app/shared/components/dividers.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/components/styled_form_field.dart';
import 'package:erp/app/shared/styles/masks.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/shared/utils/dates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EditLancamentoPage extends StatefulWidget {
  const EditLancamentoPage({Key? key, this.lancamento}) : super(key: key);

  static const String routeName = '/edit_lancamento';

  final Lancamento? lancamento;

  @override
  _EditLancamentoPagePageState createState() => _EditLancamentoPagePageState();
}

class _EditLancamentoPagePageState extends State<EditLancamentoPage> {
  late LancamentoViewModel lancamentoViewModel;
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
                      StyledFormField(
                        textEditingController: lancamentoViewModel.valorCtrl,
                        labelText: 'Valor',
                        fillColor: CustomColors.secondary,
                        borderRadius: Corners.s10Border,
                        realtimeValidation: true,
                        masks: [
                          FilteringTextInputFormatter.digitsOnly,
                          Masks.precoMask()
                        ],
                      ),
                      Dividers.dividerSimple,
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
                          labelText: 'Categoria',
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
                      Dividers.dividerSimple,
                      GestureDetector(
                        child: AbsorbPointer(
                          child: StyledFormField(
                            readOnly: true,
                            textEditingController: lancamentoViewModel.dateCtrl,
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
                      Dividers.dividerSimple,
                      GestureDetector(
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
