import 'package:erp/app/screens/produtos/edit_produto/edit_produto.dart';
import 'package:erp/app/screens/produtos/table_produtos.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/components/menu.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/components/custom_snack_bar.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/stores/produto_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({Key? key}) : super(key: key);

  static const String routeName = '/produtos';

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  ProdutoStore produtoStore = Modular.get();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      produtoStore.fetchProdutos();
    });
  }

  showErrorMessage() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          message:
              'Ocorreu um erro ao listar os produtos. Tente novamente mais tarde!',
          isError: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: CustomColors.secondary,
        body: Row(
          children: [
            Menu(page: Pages.PRODUTOS),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Produtos',
                            style:
                                TextStyles.T1.textColor(CustomColors.primary),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: CustomColors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Pesquisar',
                                style: TextStyles.Body1.textColor(
                                    CustomColors.black3),
                              ),
                              SizedBox(width: 20),
                              ImageIcon(
                                StyledIcons.search,
                                color: CustomColors.primaryVariant,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        CustomButton.primary(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          text: 'Criar produto',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          color: Colors.black12,
                                        )),
                                    Expanded(
                                      flex: 2,
                                      child: EditProdutoPage(),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder<ProdutoState>(
                      valueListenable: produtoStore,
                      builder: (context, state, child) {
                        if (state is LoadingProdutoState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is SuccessProdutoState &&
                            state.produtos.isNotEmpty) {
                          return TableProdutos(produtos: state.produtos);
                        }
                        if (state is ErrorProdutoState) {
                          showErrorMessage();
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              StyledIcons.robotConfuse,
                              color: CustomColors.primary,
                              size: 48,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Sem produtos para exibir,\nadicione clicando no botão abaixo!',
                              style: TextStyles.H1,
                              textAlign: TextAlign.center,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
