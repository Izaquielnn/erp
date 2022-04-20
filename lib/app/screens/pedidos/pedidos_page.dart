import 'package:erp/app/screens/pedidos/table_pedidos.dart';
import 'package:erp/app/services/pedido_service.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/components/custom_snack_bar.dart';
import 'package:erp/app/shared/components/menu.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/stores/pedido_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({Key? key}) : super(key: key);

  static const String routeName = '/pedidos';

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  PedidoService pedidoService = Modular.get();
  PedidoStore pedidoStore = Modular.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      pedidoStore.fetchPedidos();
    });
  }

  showErrorMessage() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          message:
              'Ocorreu um erro ao listar os pedidos. Tente novamente mais tarde!',
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
        body: Row(
          children: [
            Menu(page: Pages.PEDIDOS),
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
                            'Pedidos',
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
                          text: 'Adicionar pedido',
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
                                      child: Container(),
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
                    child: ValueListenableBuilder<PedidoState>(
                      valueListenable: pedidoStore,
                      builder: (context, state, child) {
                        if (state is LoadingPedidoState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is SuccessPedidoState &&
                            state.pedidos.isNotEmpty) {
                          return TablePedidos(pedidos: state.pedidos);
                        }
                        if (state is ErrorPedidoState) {
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
                              'Sem pedidos para exibir!',
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
            )
          ],
        ),
      ),
    );
  }
}
