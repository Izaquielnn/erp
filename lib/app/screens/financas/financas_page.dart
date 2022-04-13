import 'package:erp/app/screens/financas/card_widget.dart';
import 'package:erp/app/screens/financas/edit_lancamento/edit_lancamento_page.dart';
import 'package:erp/app/screens/financas/table_lancamentos.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/components/menu.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/components/custom_snack_bar.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/stores/lancamento_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FinancasPage extends StatefulWidget {
  const FinancasPage({Key? key}) : super(key: key);

  static const String routeName = '/financas';

  @override
  _FinancasPageState createState() => _FinancasPageState();
}

class _FinancasPageState extends State<FinancasPage> {
  LancamentoStore lancamentoStore = Modular.get();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      lancamentoStore.fetchLancamentos();
    });
  }

  showErrorMessage() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          message:
              'Ocorreu um erro ao listar as finanças. Tente novamente mais tarde!',
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
            Menu(page: Pages.FINANCAS),
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
                            'Finanças',
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
                          text: 'Criar lançamento',
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
                                      child: EditLancamentoPage(),
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
                    child: ValueListenableBuilder<LancamentoState>(
                      valueListenable: lancamentoStore,
                      builder: (context, state, child) {
                        if (state is LoadingLancamentoState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is SuccessLancamentoState &&
                            state.lancamentos.isNotEmpty) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CardWidget(
                                    title: 'SALDO',
                                    value: state.saldo,
                                    color: CustomColors.primary,
                                  ),
                                  CardWidget(
                                    title: 'ENTRADAS',
                                    value: state.entradas,
                                    color: CustomColors.success,
                                    scale: .5,
                                  ),
                                  CardWidget(
                                    title: 'SAÍDAS',
                                    value: state.saidas,
                                    scale: .5,
                                    color: CustomColors.error,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Expanded(
                                  child: TableLancamentos(
                                      lancamentos: state.lancamentos)),
                            ],
                          );
                        }
                        if (state is ErrorLancamentoState) {
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
                              'Sem lançamentos para exibir,\nadicione clicando no botão abaixo!',
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
