import 'package:erp/app/models/produto.dart';
import 'package:erp/app/screens/produtos/edit_produto/edit_produto.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoWidget extends StatefulWidget {
  const ProdutoWidget({Key? key, required this.produto}) : super(key: key);
  final Produto produto;

  @override
  _ProdutoWidgetState createState() => _ProdutoWidgetState();
}

class _ProdutoWidgetState extends State<ProdutoWidget> {
  @override
  Widget build(BuildContext context) {
    Produto produto = widget.produto;

    if (!Responsive.isMobile(context)) {
      return tableView();
    }

    return cardView(produto);
  }

  Widget tableView() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.s10Border,
        color: CustomColors.white,
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: TableProdutos(
        children: [
          Row(
            children: [
              ImageIcon(
                StyledIcons.product,
                color: CustomColors.primaryVariant,
              ),
              SizedBox(width: 10),
              Text(
                widget.produto.descricao,
                maxLines: 2,
                style: TextStyles.H2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text(
            widget.produto.codigoSKU ?? '',
            style: TextStyles.H2,
            maxLines: 2,
          ),
          Text(
            widget.produto.unidade ?? '',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.produto.grupoTributario ?? '',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'R\$ ${widget.produto.preco?.toStringAsFixed(2)}',
            maxLines: 2,
            style: TextStyles.H2,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: CustomButton.secondary(
              text: 'Editar',
              textStyle: TextStyles.H2.textColor(CustomColors.black),
              icon: ImageIcon(
                StyledIcons.edit,
                color: CustomColors.primaryVariant,
                size: 14,
              ),
              onTap: () {
                if (Responsive.isMobile(context)) {
                  Modular.to.pushNamed(EditProdutoPage.routeName,
                      arguments: widget.produto);
                } else {
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
                              produto: widget.produto,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget cardView(Produto produto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: Corners.s10Border,
        child: ExpansionTile(
          backgroundColor: CustomColors.white,
          collapsedBackgroundColor: CustomColors.white,
          iconColor: CustomColors.black,
          textColor: CustomColors.black,
          title: Row(
            children: [
              Expanded(child: Text(produto.descricao, style: TextStyles.H1)),
              Text(produto.codigoSKU ?? '', style: TextStyles.H2),
              SizedBox(width: 30),
              Text('R\$ ${produto.preco?.toStringAsFixed(2)}',
                  style: TextStyles.H2),
            ],
          ),
          childrenPadding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            buildFieldRow(
              field: 'Tipo',
              value: widget.produto.tipo,
            ),
            buildFieldRow(
              field: 'Unidade',
              value: widget.produto.unidade,
            ),
            buildFieldRow(
              field: 'Grupo tributário',
              value: widget.produto.grupoTributario,
            ),
            buildFieldRow(
              field: 'CFOP',
              value: widget.produto.CFOP,
            ),
            buildFieldRow(
              field: 'NCM',
              value: widget.produto.NCM,
            ),
            buildFieldRow(
              field: 'CEST',
              value: widget.produto.CEST,
            ),
            buildFieldRow(
              field: 'Grupo tributário',
              value: widget.produto.grupoTributario,
            ),
            buildFieldRow(
              field: 'Origem',
              value: widget.produto.origem,
            ),
            SizedBox(height: 20),
            CustomButton.secondary(
              text: 'Editar produto',
              onTap: () {
                if (Responsive.isMobile(context)) {
                  Modular.to
                      .pushNamed(EditProdutoPage.routeName, arguments: produto);
                } else {
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
                              produto: widget.produto,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              icon: ImageIcon(
                StyledIcons.edit,
                color: CustomColors.primary,
                size: 18,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildFieldRow({required String field, String? value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                field,
                style: TextStyles.Body2.textColor(CustomColors.primaryVariant),
              ),
            ),
            Expanded(
              child: Text(
                value ?? '-',
                style: TextStyles.Body2,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}

class TableProdutos extends StatelessWidget {
  List<Widget> children;
  TableProdutos({
    Key? key,
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: <int, TableColumnWidth>{5: IntrinsicColumnWidth()},
      children: [TableRow(children: children)],
    );
  }
}
