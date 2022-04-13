import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/screens/financas/edit_lancamento/edit_lancamento_page.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/components/custom_table.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/shared/utils/dates.dart';
import 'package:flutter/material.dart';

class TableLancamentos extends StatelessWidget {
  const TableLancamentos({
    Key? key,
    required this.lancamentos,
  }) : super(key: key);
  final List<Lancamento> lancamentos;

  @override
  Widget build(BuildContext context) {
    return CustomTable<Lancamento>(
      items: lancamentos,
      columns: [
        CustomItem(
          columnName: 'Data',
          columnBuilder: (lancamento) => Row(
            children: [
              ImageIcon(
                StyledIcons.money,
                color: CustomColors.primaryVariant,
              ),
              SizedBox(width: 3),
              Flexible(
                child: Text(
                  Dates.format(lancamento.createdAt),
                  style: TextStyles.Body3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        CustomItem(
          columnName: 'Contato',
          columnBuilder: (lancamento) => Text(
            lancamento.cliente?.nome ?? '',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          flex: 2,
          columnName: 'Descrição',
          columnBuilder: (lancamento) => Text(
            lancamento.descricao,
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'Forma de pagamento',
          columnBuilder: (lancamento) => Text(
            lancamento.formaPagamento ?? '',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'Conta',
          columnBuilder: (lancamento) => Text(
            lancamento.conta,
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'Categoria',
          columnBuilder: (lancamento) => Text(
            lancamento.categoria ?? '',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'Valor',
          columnBuilder: (lancamento) => Text(
            'R\$ ${lancamento.valor.toStringAsFixed(2)}',
            style: TextStyles.H2.textColor(
              lancamento.valor >= 0 ? CustomColors.success : CustomColors.error,
            ),
          ),
        ),
        CustomItem(
          columnName: 'AÇÕES',
          columnBuilder: (lancamento) => Container(
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
                          child: EditLancamentoPage(
                            lancamento: lancamento,
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
