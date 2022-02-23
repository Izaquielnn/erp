import 'package:erp/app/models/contato.dart';
import 'package:erp/app/screens/contatos/contato_widget.dart';
import 'package:erp/app/shared/custom_colors.dart';
import 'package:erp/app/shared/styles.dart';
import 'package:flutter/material.dart';

class ContatosPage extends StatefulWidget {
  const ContatosPage({Key? key}) : super(key: key);

  static const String routeName = '/contatos';

  @override
  _ContatosPageState createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  List<Contato> contatos = [
    Contato(nome: 'Pedrin jr', cnpj: '11653677422'),
    Contato(nome: 'Joao da budega', contatos: ['(83) 99820319']),
    Contato(
        nome: 'Moura baterias', contatos: ['(83) 99820319', '(83) 45684564'])
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondary,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contatos',
                    style:
                        TextStyles.T1.textColor(CustomColors.primary).size(24),
                  ),
                  Icon(
                    Icons.search,
                    color: CustomColors.primary,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: contatos.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  Contato contato = contatos[index];
                  return ContatoWidget(contato: contato);
                }),
          ),
        ],
      ),
    );
  }
}
