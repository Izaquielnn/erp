import 'package:erp/app/models/pedido.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/components/custom_table.dart';
import 'package:erp/app/shared/components/tag.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/shared/utils/dates.dart';
import 'package:flutter/material.dart';

class TablePedidos extends StatelessWidget {
  const TablePedidos({
    Key? key,
    required this.pedidos,
  }) : super(key: key);
  final List<Pedido> pedidos;

  @override
  Widget build(BuildContext context) {
    return CustomTable<Pedido>(
      items: pedidos,
      columns: [
        CustomItem(
          columnName: 'DATA',
          columnBuilder: (pedido) => Row(
            children: [
              ImageIcon(
                StyledIcons.label,
                color: CustomColors.primaryVariant,
                size: 16,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  Dates.format(pedido.createdAt),
                  maxLines: 2,
                  style: TextStyles.Body3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        CustomItem(
          columnName: 'CLIENTE',
          columnBuilder: (pedido) => Text(
            pedido.cliente.nome,
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          flex: 2,
          columnName: 'DESCRIÇÃO',
          columnBuilder: (pedido) => Text(
            pedido.produtos.join('; '),
            maxLines: 2,
            style: TextStyles.Body3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'TOTAL',
          columnBuilder: (pedido) => Text(
            'R\$ ${pedido.produtos.fold<double>(0, (previus, p) => previus + p.valor).toStringAsFixed(2)}',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'ENTREGA PREVISTA',
          columnBuilder: (pedido) => Text(
            Dates.format(pedido.previsao_entrega),
            style: TextStyles.H2,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'FRETE',
          columnBuilder: (produto) => Text(
            produto.modalidade_frete.value,
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'STATUS',
          columnBuilder: (pedido) => Tag(
            tagName: pedido.status.value,
            tagColor: CustomColors.fromPedidoStatus(
              pedido.status,
            ),
          ),
        ),
        CustomItem(
          columnName: 'AÇÕES',
          columnBuilder: (produto) => Container(
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
                          child: Container(),
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
