import 'package:erp/app/services/produto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoViewModel extends ChangeNotifier {
  var loading = ValueNotifier(false);
  var addUnidadeButtonText = ValueNotifier('');
  var unidades = ValueNotifier(['KG', 'UN']);

  ProdutoService produtoService = Modular.get();
  final formKey = GlobalKey<FormState>();

  TextEditingController descricaoCtrl = TextEditingController();
  TextEditingController precoCtrl = TextEditingController();
  TextEditingController codigoSKUCtrl = TextEditingController();
  TextEditingController tipoCtrl = TextEditingController();
  TextEditingController unidadeCtrl = TextEditingController();
  TextEditingController grupoTributarioCtrl = TextEditingController();
  TextEditingController CFOPCtrl = TextEditingController();
  TextEditingController NCMCtrl = TextEditingController();
  TextEditingController CESTCtrl = TextEditingController();
  TextEditingController origemCtrl = TextEditingController();

  save() {
    formKey.currentState!.validate();
  }

  void addUnidade(String unidade) {
    if (!unidades.value.contains(unidade)) {
      unidades.value = unidades.value..add(unidade);
    }
  }

  void setAddButtonText(String text) {
    if (text.isNotEmpty && !unidades.value.contains(text)) {
      addUnidadeButtonText.value = text;
    } else {
      addUnidadeButtonText.value = '';
    }
  }
}
