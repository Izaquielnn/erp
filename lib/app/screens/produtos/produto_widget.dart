import 'package:erp/app/models/produto.dart';
import 'package:erp/app/screens/produtos/edit_produto/edit_produto.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
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
                Modular.to
                    .pushNamed(EditProdutoPage.routeName, arguments: produto);
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
