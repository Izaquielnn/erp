import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:erp/app/models/produto.dart';
import 'package:erp/app/screens/produtos/edit_produto/product_view_model.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/components/custom_dropdown.dart';
import 'package:erp/app/shared/components/dividers.dart';
import 'package:erp/app/shared/components/styled_form_field.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/masks.dart';
import 'package:erp/app/shared/styles/styles.dart';

class EditProdutoPage extends StatelessWidget {
  EditProdutoPage({
    Key? key,
    this.produto,
  }) : super(key: key) {
    produtoViewModel = ProdutoViewModel(produto: produto);
  }

  static const String routeName = '/edit_produto';

  final Produto? produto;
  late ProdutoViewModel produtoViewModel;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: produtoViewModel.scaffoldMessengerKey,
      child: Scaffold(
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
                        produto == null
                            ? 'Adicionar produto'
                            : 'Editar produto',
                        style: TextStyles.T1.textColor(CustomColors.primary),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: produtoViewModel.loading,
                      builder: (context, loading, _) => loading
                          ? CircularProgressIndicator()
                          : CustomButton.primary(
                              text: 'Salvar',
                              onTap: () => produtoViewModel.save(context),
                              icon: Icon(
                                Icons.check,
                                color: CustomColors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Form(
                    key: produtoViewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dados gerais',
                          style:
                              TextStyles.Body1.textColor(CustomColors.black2),
                        ),
                        Dividers.dividerSimpleTiny,
                        StyledFormField(
                          textEditingController: produtoViewModel.descricaoCtrl,
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
                          textEditingController: produtoViewModel.codigoSKUCtrl,
                          labelText: 'Código(SKU)',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                        ),
                        Dividers.dividerSimple,
                        CustomDropDown(
                          itens: produtoViewModel.tipos.value,
                          onTap: (tipo) {
                            produtoViewModel.tipoCtrl.text = tipo;
                          },
                          child: StyledFormField(
                            textEditingController: produtoViewModel.tipoCtrl,
                            labelText: 'Tipo',
                            fillColor: CustomColors.secondary,
                            borderRadius: Corners.s10Border,
                            realtimeValidation: true,
                          ),
                        ),
                        Dividers.dividerSimple,
                        CustomDropDown(
                          itens: produtoViewModel.unidades.value,
                          onTap: (unidade) {
                            produtoViewModel.unidadeCtrl.text = unidade;
                          },
                          child: StyledFormField(
                            readOnly: true,
                            textEditingController: produtoViewModel.unidadeCtrl,
                            labelText: 'Unidade',
                            fillColor: CustomColors.secondary,
                            borderRadius: Corners.s10Border,
                            realtimeValidation: true,
                          ),
                        ),
                        Dividers.dividerSimple,
                        StyledFormField(
                          textEditingController: produtoViewModel.precoCtrl,
                          labelText: 'Preço',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                          masks: [
                            FilteringTextInputFormatter.digitsOnly,
                            Masks.precoMask()
                          ],
                        ),
                        Dividers.dividerGroup,
                        Text(
                          'Tributação',
                          style:
                              TextStyles.Body1.textColor(CustomColors.black2),
                        ),
                        Dividers.dividerSimpleTiny,
                        CustomDropDown(
                          itens: produtoViewModel.gruposTributarios.value,
                          onTap: (grupo) {
                            produtoViewModel.grupoTributarioCtrl.text = grupo;
                          },
                          child: StyledFormField(
                            textEditingController:
                                produtoViewModel.grupoTributarioCtrl,
                            labelText: 'Grupo tributário',
                            readOnly: true,
                            fillColor: CustomColors.secondary,
                            borderRadius: Corners.s10Border,
                            realtimeValidation: true,
                          ),
                        ),
                        Dividers.dividerSimple,
                        StyledFormField(
                          textEditingController: produtoViewModel.CFOPCtrl,
                          labelText: 'CFOP Padrão',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                        ),
                        Dividers.dividerSimple,
                        StyledFormField(
                          textEditingController: produtoViewModel.NCMCtrl,
                          labelText: 'NCM',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                        ),
                        Dividers.dividerSimple,
                        StyledFormField(
                          textEditingController: produtoViewModel.CESTCtrl,
                          labelText: 'CEST',
                          fillColor: CustomColors.secondary,
                          borderRadius: Corners.s10Border,
                          realtimeValidation: true,
                        ),
                        Dividers.dividerSimple,
                        CustomDropDown(
                          itens: produtoViewModel.origens.value,
                          onTap: (origem) {
                            produtoViewModel.origemCtrl.text = origem;
                          },
                          child: StyledFormField(
                            textEditingController: produtoViewModel.origemCtrl,
                            labelText: 'Origem',
                            readOnly: true,
                            fillColor: CustomColors.secondary,
                            borderRadius: Corners.s10Border,
                            realtimeValidation: true,
                          ),
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
