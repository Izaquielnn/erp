import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/shared/utils/dates.dart';
import 'package:flutter/material.dart';

class LancamentoViewModel extends ChangeNotifier {
  Lancamento? lancamento;

  final formKey = GlobalKey<FormState>();
  TextEditingController descricaoCtrl = TextEditingController();
  TextEditingController valorCtrl = TextEditingController();
  TextEditingController contaCtrl = TextEditingController();
  TextEditingController categoriaCtrl = TextEditingController();
  TextEditingController competenciaCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();

  late DateTime competenciaDate;
  late DateTime date;
  var contas = ValueNotifier(['Banco do Brasil', 'Caixa']);
  var categorias =
      ValueNotifier(['Venda de produtos', 'Geral', 'Folha de pagamento']);

  bool loading = false;

  LancamentoViewModel({this.lancamento}) {
    DateTime now = DateTime.now();
    competenciaDate = now;
    date = now;
    competenciaCtrl.text = Dates.format(now);
    dateCtrl.text = Dates.format(now);
  }

  save(BuildContext context) {
    formKey.currentState!.validate();
  }
}
