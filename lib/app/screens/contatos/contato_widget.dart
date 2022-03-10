import 'package:erp/app/models/contato.dart';
import 'package:erp/app/screens/contatos/edit_contato/edit_contato_page.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContatoWidget extends StatefulWidget {
  const ContatoWidget({Key? key, required this.contato}) : super(key: key);
  final Contato contato;

  @override
  _ContatoWidgetState createState() => _ContatoWidgetState();
}

class _ContatoWidgetState extends State<ContatoWidget> {
  @override
  Widget build(BuildContext context) {
    Contato contato = widget.contato;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: Corners.s10Border,
        child: ExpansionTile(
          backgroundColor: CustomColors.white,
          collapsedBackgroundColor: CustomColors.white,
          iconColor: CustomColors.black,
          textColor: CustomColors.black,
          leading: ImageIcon(
              contato.cnpj == null ? StyledIcons.user : StyledIcons.industry),
          title: Text(contato.nome, style: TextStyles.H1),
          childrenPadding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            ...fieldsToShow(contato),
            SizedBox(height: 20),
            CustomButton.secondary(
              text: 'Editar contato',
              onTap: () {
                if (Responsive.isMobile(context)) {
                  Modular.to
                      .pushNamed(EditContatoPage.routeName, arguments: contato);
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
                            child: EditContatoPage(
                              contato: widget.contato,
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

  List<Widget> fieldsToShow(Contato contato) {
    List<Widget> fields = [];

    if (contato.cnpj != null) {
      fields.add(buildFieldRow(field: 'CNPJ', value: contato.cnpj));
      fields.add(buildFieldRow(
          field: 'Razão social', value: contato.empresa.razaoSozial));
      fields.add(buildFieldRow(
          field: 'Ins. Estadual', value: contato.empresa.inscEstadual));
    } else {
      fields.add(buildFieldRow(field: 'CPF', value: contato.cpf));
    }

    fields.add(
        buildFieldRow(field: 'Contatos', value: contato.contatos.join('\n')));

    fields.add(
        buildFieldRow(field: 'Endereço', value: contato.endereco.toString()));
    fields.add(buildFieldRow(field: 'Email', value: contato.email));

    return fields;
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
