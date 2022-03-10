import 'package:erp/app/models/contato.dart';
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
  TextEditingController contatoCtrl = TextEditingController();
  var contato = ValueNotifier<Contato?>(null);

  late DateTime competenciaDate;
  late DateTime date;
  TextEditingController tipoCtrl =
      TextEditingController(text: Tipo.ENTRADA.value);
  var tipo = ValueNotifier(Tipo.ENTRADA);
  var tipos = Tipo.values.map((e) => e.value).toList();

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

enum Tipo { ENTRADA, SAIDA }

extension TipoExtension on Tipo {
  String get value {
    switch (this) {
      case Tipo.ENTRADA:
        return 'Entrada';
      case Tipo.SAIDA:
        return 'Saída';
    }
  }
}
