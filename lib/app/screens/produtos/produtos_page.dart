import 'package:erp/app/models/produto.dart';
import 'package:erp/app/screens/produtos/edit_produto/edit_produto.dart';
import 'package:erp/app/screens/produtos/produto_widget.dart';
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
    return Scaffold(
      backgroundColor: CustomColors.secondary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed(EditProdutoPage.routeName);
        },
        backgroundColor: CustomColors.primary,
        child: Icon(
          Icons.add,
          size: 36,
        ),
      ),
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
                      'Produtos',
                      style: TextStyles.T1.textColor(CustomColors.primary),
                    ),
                  ),
                  ImageIcon(
                    StyledIcons.search,
                    color: CustomColors.primary,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<ProdutoState>(
              valueListenable: produtoStore,
              builder: (context, state, child) {
                if (state is LoadingProdutoState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is SuccessProdutoState && state.produtos.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.produtos.length,
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      Produto produto = state.produtos[index];
                      return ProdutoWidget(produto: produto);
                    },
                  );
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
    );
  }
}
