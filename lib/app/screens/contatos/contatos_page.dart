import 'package:erp/app/models/contato.dart';
import 'package:erp/app/screens/contatos/edit_contato/edit_contato_page.dart';
import 'package:erp/app/screens/contatos/table_contatos.dart';
import 'package:erp/app/shared/components/custom_appbar.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/components/menu.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/components/custom_snack_bar.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/stores/contato_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContatosPage extends StatefulWidget {
  const ContatosPage({Key? key}) : super(key: key);

  static const String routeName = '/contatos';

  @override
  _ContatosPageState createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  ContatoStore contatoStore = Modular.get();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      contatoStore.fetchContatos();
    });
  }

  showErrorMessage() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          message:
              'Ocorreu um erro ao listar os contatos. Tente novamente mais tarde!',
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
            Menu(page: Pages.CONTATOS),
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
                            'Contatos',
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
                          text: 'Criar contato',
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
                                      child: EditContatoPage(),
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
                    child: ValueListenableBuilder(
                      valueListenable: contatoStore,
                      builder: (context, state, child) {
                        if (state is LoadingContatoState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is SuccessContatoState &&
                            state.contatos.isNotEmpty) {
                          return TableContatos(contatos: state.contatos);
                        }
                        if (state is ErrorContatoState) {
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
                              'Sem contatos para exibir,\nadicione clicando no botão abaixo!',
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
