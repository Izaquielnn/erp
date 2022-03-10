import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/screens/financas/edit_lancamento/edit_lancamento_page.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/shared/utils/dates.dart';
import 'package:erp/app/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LancamentoWidget extends StatefulWidget {
  const LancamentoWidget({Key? key, required this.lancamento})
      : super(key: key);
  final Lancamento lancamento;

  @override
  _LancamentoWidgetState createState() => _LancamentoWidgetState();
}

class _LancamentoWidgetState extends State<LancamentoWidget> {
  @override
  Widget build(BuildContext context) {
    if (!Responsive.isMobile(context)) {
      return tableView();
    }
    return cardView();
  }

  Widget tableView() {
    EdgeInsets padding = EdgeInsets.symmetric(horizontal: 10);
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.s10Border,
        color: CustomColors.white,
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: TableLancamentos(
        children: [
          Row(
            children: [
              ImageIcon(
                StyledIcons.money,
                color: CustomColors.primaryVariant,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Dates.format(widget.lancamento.createdAt),
                    style: TextStyles.Body3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.lancamento.cliente?.nome ?? '',
                    style: TextStyles.H2,
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: padding,
            child: Text(
              widget.lancamento.descricao,
              maxLines: 2,
              style: TextStyles.H2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: padding,
            child: Text(
              widget.lancamento.formaPagamento ?? '',
              maxLines: 2,
              style: TextStyles.H2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: padding,
            child: Text(
              widget.lancamento.conta,
              maxLines: 2,
              style: TextStyles.H2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: padding,
            child: Text(
              widget.lancamento.categoria ?? '',
              maxLines: 2,
              style: TextStyles.H2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: padding,
            child: Text(
              'R\$ ${widget.lancamento.valor.toStringAsFixed(2)}',
              style: TextStyles.H2.textColor(
                widget.lancamento.valor >= 0
                    ? CustomColors.success
                    : CustomColors.error,
              ),
            ),
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
                  Modular.to.pushNamed(EditLancamentoPage.routeName,
                      arguments: widget.lancamento);
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
                            child: EditLancamentoPage(
                              lancamento: widget.lancamento,
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

  Widget cardView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: Corners.s10Border,
        child: ExpansionTile(
          backgroundColor: CustomColors.white,
          collapsedBackgroundColor: CustomColors.white,
          iconColor: CustomColors.black,
          textColor: CustomColors.black,
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Dates.format(widget.lancamento.createdAt),
                style: TextStyles.Body3,
              ),
              Text(
                widget.lancamento.cliente?.nome ?? '',
                style: TextStyles.Body2,
              )
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.lancamento.descricao, style: TextStyles.Body1),
              Text(
                'R\$ ${widget.lancamento.valor.toStringAsFixed(2)}',
                style: TextStyles.Body1.textColor(
                  widget.lancamento.valor >= 0
                      ? CustomColors.success
                      : CustomColors.error,
                ),
              )
            ],
          ),
          childrenPadding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: 20),
            CustomButton.secondary(
              text: 'Editar lançamento',
              onTap: () {
                // Modular.to.pushNamed(EditLancamentoPage.routeName,
                //     arguments: contato);
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

class TableLancamentos extends StatelessWidget {
  List<Widget> children;
  TableLancamentos({
    Key? key,
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: <int, TableColumnWidth>{1: FlexColumnWidth(1)},
      children: [TableRow(children: children)],
    );
  }
}
