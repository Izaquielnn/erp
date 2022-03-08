import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/shared/utils/dates.dart';
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
    Lancamento lancamento = widget.lancamento;

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
                Dates.format(lancamento.createdAt),
                style: TextStyles.Body3,
              ),
              Text(
                lancamento.cliente?.nome ?? '',
                style: TextStyles.Body2,
              )
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(lancamento.descricao, style: TextStyles.Body1),
              Text(
                'R\$ ${lancamento.valor.toStringAsFixed(2)}',
                style: TextStyles.Body1.textColor(
                  lancamento.valor >= 0
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
