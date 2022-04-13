import 'package:erp/app/models/produto.dart';
import 'package:erp/app/screens/produtos/edit_produto/edit_produto.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/components/custom_table.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class TableProdutos extends StatelessWidget {
  const TableProdutos({
    Key? key,
    required this.produtos,
  }) : super(key: key);
  final List<Produto> produtos;

  @override
  Widget build(BuildContext context) {
    return CustomTable<Produto>(
      items: produtos,
      columns: [
        CustomItem(
          columnName: 'PRODUTO',
          columnBuilder: (produto) => Row(
            children: [
              ImageIcon(
                StyledIcons.product,
                color: CustomColors.primaryVariant,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  produto.descricao,
                  maxLines: 2,
                  style: TextStyles.H2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        CustomItem(
          columnName: 'CÓDIGO(SKU)',
          columnBuilder: (produto) => Text(
            produto.codigoSKU ?? '',
            style: TextStyles.H2,
            maxLines: 2,
          ),
        ),
        CustomItem(
          columnName: 'UNIDADE',
          columnBuilder: (produto) => Text(
            produto.unidade ?? '',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'TRIBUTAÇÃO',
          columnBuilder: (produto) => Text(
            produto.grupoTributario ?? '',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomItem(
          columnName: 'PREÇO',
          columnBuilder: (produto) => Text(
            'R\$ ${produto.preco?.toStringAsFixed(2)}',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
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
                          child: EditProdutoPage(
                            produto: produto,
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
