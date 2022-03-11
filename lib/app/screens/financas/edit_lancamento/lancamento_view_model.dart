import 'package:erp/app/models/contato.dart';
import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/services/financas_service.dart';
import 'package:erp/app/shared/components/custom_snack_bar.dart';
import 'package:erp/app/shared/utils/dates.dart';
import 'package:erp/app/shared/utils/http_response.dart';
import 'package:erp/app/stores/lancamento_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LancamentoViewModel extends ChangeNotifier {
  Lancamento? lancamento;
  FinancasService financasService = Modular.get();
  LancamentoStore lancamentoStore = Modular.get();

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

  TextEditingController descricaoCtrl = TextEditingController();
  TextEditingController valorCtrl = TextEditingController();
  TextEditingController contaCtrl = TextEditingController();
  TextEditingController categoriaCtrl = TextEditingController();
  TextEditingController competenciaCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController contatoCtrl = TextEditingController();
  TextEditingController formaPagamentoCtrl = TextEditingController();
  var contato = ValueNotifier<Contato?>(null);

  late DateTime competenciaDate;
  late DateTime date;
  TextEditingController tipoCtrl =
      TextEditingController(text: Tipo.ENTRADA.value);
  var tipo = ValueNotifier(Tipo.ENTRADA);
  var tipos = Tipo.values.map((e) => e.value).toList();

  var contas = ValueNotifier(['Banco do Brasil', 'Caixa']);
  var formasPagamento = ValueNotifier(['Dinheiro', 'Cheque']);
  var categorias =
      ValueNotifier(['Venda de produtos', 'Geral', 'Folha de pagamento']);

  bool loading = false;

  LancamentoViewModel({this.lancamento}) {
    DateTime now = DateTime.now();
    competenciaDate = now;
    date = now;

    if (lancamento != null) {
      descricaoCtrl.text = lancamento?.descricao ?? '';

      valorCtrl.text = 'R\$ ${lancamento?.valor.toStringAsFixed(2) ?? 0.0}';
      tipo.value = (lancamento?.valor ?? 0) < 0 ? Tipo.SAIDA : Tipo.ENTRADA;
      tipoCtrl.text = tipo.value.value;

      contaCtrl.text = lancamento?.conta ?? '';
      categoriaCtrl.text = lancamento?.categoria ?? '';
      date = lancamento?.createdAt ?? now;
      competenciaDate = lancamento?.competencia ?? now;
      contato.value = lancamento?.cliente;
      contatoCtrl.text = contato.value?.nome ?? '';
      formaPagamentoCtrl.text = lancamento?.formaPagamento ?? '';
    }
    competenciaCtrl.text = Dates.format(now);
    dateCtrl.text = Dates.format(now);
  }

  save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      HttpResponse<Lancamento> response;

      Lancamento newLancamento = Lancamento(
        descricao: descricaoCtrl.text,
        valor: getValor(),
        conta: contaCtrl.text,
        createdAt: date,
        competencia: competenciaDate,
        categoria: categoriaCtrl.text,
        cliente: contato.value,
        formaPagamento: formaPagamentoCtrl.text,
      );

      if (lancamento != null) {
        newLancamento.id = lancamento?.id;
        response = await financasService.updateLancamento(newLancamento);
      } else {
        response = await financasService.addLancamento(newLancamento);
      }

      scaffoldMessengerKey.currentState?.showSnackBar(
        CustomSnackBar(message: response.message, isError: !response.success),
      );

      if (response.success) {
        lancamentoStore.fetchLancamentos();
        await Future.delayed(Duration(seconds: 1));
        Modular.to.pop();
      }
    }
  }

  double getValor() {
    String _onlyDigits = valorCtrl.text.replaceAll(RegExp('[^0-9]'), "");
    double valor = double.parse(_onlyDigits) / 100;
    if (tipo.value == Tipo.SAIDA) {
      valor *= -1;
    }
    return valor;
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
