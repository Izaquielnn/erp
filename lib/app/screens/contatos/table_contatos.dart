import 'package:erp/app/models/contato.dart';
import 'package:erp/app/screens/contatos/edit_contato/edit_contato_page.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/components/custom_table.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class TableContatos extends StatelessWidget {
  const TableContatos({
    Key? key,
    required this.contatos,
  }) : super(key: key);
  final List<Contato> contatos;

  @override
  Widget build(BuildContext context) {
    return CustomTable<Contato>(
      items: contatos,
      columns: [
        CustomItem(
          columnName: 'NOME',
          columnBuilder: (contato) => Row(
            children: [
              ImageIcon(
                contato.cnpj == null ? StyledIcons.user : StyledIcons.industry,
                color: CustomColors.primaryVariant,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  contato.nome,
                  maxLines: 2,
                  style: TextStyles.H2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        CustomItem(
          columnName: 'CPF / CNPJ',
          columnBuilder: (contato) => Text(
            contato.cnpj ?? contato.cpf ?? '',
            style: TextStyles.H2,
            maxLines: 2,
          ),
        ),
        CustomItem(
          columnName: 'CONTATOS',
          columnBuilder: (contato) => Text(
            contato.contatos.join('\n'),
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'ENDEREÇO',
          columnBuilder: (contato) => Text(
            contato.endereco.toString(),
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'AÇÕES',
          columnBuilder: (contato) => Container(
            alignment: Alignment.center,
            child: CustomButton.secondary(
              text: 'Editar',
              textStyle: TextStyles.H2.textColor(CustomColors.black),
              icon: ImageIcon(
                StyledIcons.edit,
                color: CustomColors.primaryVariant,
                size: 14,
              ),
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
                          child: EditContatoPage(
                            contato: contato,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
