import 'package:erp/app/models/produto.dart';
import 'package:erp/app/services/produto_service.dart';
import 'package:erp/app/shared/components/custom_snack_bar.dart';
import 'package:erp/app/shared/utils/http_response.dart';
import 'package:erp/app/stores/produto_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoViewModel extends ChangeNotifier {
  ProdutoService produtoService = Modular.get();
  ProdutoStore produtoStore = Modular.get();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  Produto? produto;
  var loading = ValueNotifier(false);
  var unidades = ValueNotifier(['KG', 'UN']);
  var tipos = ValueNotifier(['Produto', 'Serviço']);
  var origens = ValueNotifier([
    '0 - Nacional, exceto as indicadas nos códigos 3, 4, 5 e 8',
    '1 - Estrangeira - importação direta, exceto a indicada no código 6',
    '2 - Estrangeira - adquirida no mercado interno, exceto a indicada no código 7',
    '3 - Nacional, mercadoria ou bem com conteúdo de importação superior a 40% e inferior ou igual a 70%',
    '4 - Nacional, cuja produção tenha sido feita em conformidade com os processos produtivos básicos de que tratam as legislações citadas nos ajustes',
    '5 - Nacional, mercadoria ou bem com conteúdo de importação inferior a 40%',
    '6 - Estrangeira - importação direta, sem similar nacional, contante em lista da CAMEX',
    '7 - Estrangeira - adquirida no mercado interno, sem similar nacional, contante em lista da CAMEX',
    '8 - Nacional, mercadoria ou bem com conteúdo de importação superior a 70%',
  ]);

  var gruposTributarios = ValueNotifier([
    'Simples Nacional',
    'Lucro Presumido',
    'Lucro Real',
  ]);

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

  ProdutoViewModel({this.produto}) {
    descricaoCtrl.text = produto?.descricao ?? '';
    precoCtrl.text = 'R\$ ${produto?.preco?.toStringAsFixed(2) ?? 0.0}';
    codigoSKUCtrl.text = produto?.codigoSKU ?? '';
    tipoCtrl.text =
        produto?.tipo != null ? produto?.tipo ?? '' : tipos.value.first;
    unidadeCtrl.text = produto?.unidade != null
        ? produto?.unidade ?? ''
        : unidades.value.first;
    grupoTributarioCtrl.text = produto?.grupoTributario != null
        ? produto?.grupoTributario ?? ''
        : gruposTributarios.value.first;
    CFOPCtrl.text = produto?.CFOP ?? '';
    CESTCtrl.text = produto?.CEST ?? '';
    NCMCtrl.text = produto?.NCM ?? '';
    origemCtrl.text =
        produto?.origem != null ? produto?.origem ?? '' : origens.value.first;
  }

  save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      Produto newProduto = Produto(
        descricao: descricaoCtrl.text,
        codigoSKU: codigoSKUCtrl.text.isNotEmpty ? codigoSKUCtrl.text : null,
        CFOP: CFOPCtrl.text.isNotEmpty ? CFOPCtrl.text : null,
        NCM: NCMCtrl.text.isNotEmpty ? NCMCtrl.text : null,
        grupoTributario: grupoTributarioCtrl.text.isNotEmpty
            ? grupoTributarioCtrl.text
            : null,
        origem: origemCtrl.text.isNotEmpty ? origemCtrl.text : null,
        preco: precoCtrl.text.isNotEmpty ? getPrice() : null,
        tipo: tipoCtrl.text.isNotEmpty ? tipoCtrl.text : null,
        unidade: unidadeCtrl.text.isNotEmpty ? unidadeCtrl.text : null,
        CEST: CESTCtrl.text.isNotEmpty ? CESTCtrl.text : null,
      );
      HttpResponse<Produto> response;

      if (produto != null) {
        newProduto.id = produto?.id;
        response = await produtoService.updateProduto(newProduto);
      } else {
        response = await produtoService.addProduto(newProduto);
      }

      if (response.success) {
        produtoStore.fetchProdutos();
      }

      scaffoldMessengerKey.currentState?.showSnackBar(
        CustomSnackBar(message: response.message, isError: !response.success),
      );
    }
  }

  double getPrice() {
    String _onlyDigits = precoCtrl.text.replaceAll(RegExp('[^0-9]'), "");
    return double.parse(_onlyDigits) / 100;
  }

  void addUnidade(String unidade) {
    if (!unidades.value.contains(unidade)) {
      unidades.value = unidades.value..add(unidade);
    }
  }
}
