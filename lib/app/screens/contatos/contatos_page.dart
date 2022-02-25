import 'package:erp/app/models/contato.dart';
import 'package:erp/app/screens/contatos/contato_widget.dart';
import 'package:erp/app/screens/edit_contato/edit_contato_page.dart';
import 'package:erp/app/services/contato_service.dart';
import 'package:erp/app/shared/custom_colors.dart';
import 'package:erp/app/shared/custom_snack_bar.dart';
import 'package:erp/app/shared/styled_icons.dart';
import 'package:erp/app/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContatosPage extends StatefulWidget {
  const ContatosPage({Key? key}) : super(key: key);

  static const String routeName = '/contatos';

  @override
  _ContatosPageState createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  ContatoService contatoService = Modular.get();

  List<Contato> contatos = [];

  bool loading = false;

  @override
  initState() {
    getContatos();
    super.initState();
  }

  getContatos() async {
    setState(() => loading = true);
    List<Contato>? requestedContatos = await contatoService.getContatos();
    if (requestedContatos != null) {
      contatos = requestedContatos;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            message:
                'Não foi possível buscar os contatos. Tente novamente mais tarde!',
            isError: true),
      );
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Column(
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

    if (loading) {
      body = Center(child: CircularProgressIndicator());
    }

    if (contatos.isNotEmpty) {
      body = ListView.builder(
          itemCount: contatos.length,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            Contato contato = contatos[index];
            return ContatoWidget(contato: contato);
          });
    }
    return Scaffold(
      backgroundColor: CustomColors.secondary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed(EditContatoPage.routeName);
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
                      'Contatos',
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
            child: body,
          ),
        ],
      ),
    );
  }
}
