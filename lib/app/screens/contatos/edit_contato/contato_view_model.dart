import 'package:erp/app/models/contato.dart';
import 'package:erp/app/models/empresa.dart';
import 'package:erp/app/models/endereco.dart';
import 'package:erp/app/services/cep_service.dart';
import 'package:erp/app/services/contato_service.dart';
import 'package:erp/app/shared/components/custom_snack_bar.dart';
import 'package:erp/app/shared/utils/http_response.dart';
import 'package:erp/app/shared/styles/masks.dart';
import 'package:erp/app/stores/contato_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ContatoViewModel extends ChangeNotifier {
  ContatoService contatoService = Modular.get();
  ContatoStore contatoStore = Modular.get();
  Contato? contato;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

  final formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  Map<TextEditingController, MaskTextInputFormatter> contatosControllers = {};
  TextEditingController cpfCnpjController = TextEditingController();
  TextEditingController razaSocialController = TextEditingController();
  TextEditingController inscEstadualController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ContatoViewModel({this.contato}) {
    if (contato != null) {
      nomeController.text = contato?.nome ?? '';

      cepController.text = contato?.endereco.cep ?? '';
      cepMask = Masks.cepMask(text: cepController.text);
      cidadeController.text = contato?.endereco.cidade ?? '';
      logradouroController.text = contato?.endereco.logradouro ?? '';
      ufController.text = contato?.endereco.uf ?? '';
      bairroController.text = contato?.endereco.bairro ?? '';
      numeroController.text = contato?.endereco.numero ?? '';
      complementoController.text = contato?.endereco.complemento ?? '';
      emailController.text = contato?.email ?? '';
      for (String num in contato?.contatos ?? []) {
        addContatoInput(text: num);
      }
      if (contato!.cpf != null) {
        cpf_cnpj = CPF_CNPJ.CPF;
        cpfCnpjController.text = contato?.cpf ?? '';
        cpfCnpjMask = Masks.cpfCnpjMask(
            text: cpfCnpjController.text, mask: Masks.cpfMask);
      } else if (contato?.cnpj != null) {
        cpf_cnpj = CPF_CNPJ.CNPJ;
        cpfCnpjController.text = contato?.cnpj ?? '';
        cpfCnpjMask = Masks.cpfCnpjMask(
            text: cpfCnpjController.text, mask: Masks.cnpjMask);
        razaSocialController.text = contato?.empresa.razaoSozial ?? '';
        inscEstadualController.text = contato?.empresa.inscEstadual ?? '';
        insEstadualMask =
            Masks.insEstadualMask(text: inscEstadualController.text);
      }
    }
    if (contatosControllers.isEmpty) addContatoInput();
    cpfCnpjController.addListener(cpfCnpjListener);
    cepController.addListener(cepListener);
  }

  MaskTextInputFormatter cpfCnpjMask = Masks.cpfCnpjMask();
  CPF_CNPJ cpf_cnpj = CPF_CNPJ.NONE;

  MaskTextInputFormatter insEstadualMask = Masks.insEstadualMask();

  MaskTextInputFormatter cepMask = Masks.cepMask();

  addContatoInput({String text = ''}) {
    if (contatosControllers.length < 4) {
      contatosControllers.putIfAbsent(
        TextEditingController(text: text),
        () => Masks.contatoMask(text: text),
      );
      notifyListeners();
    }
  }

  removeContatoInput(TextEditingController input) {
    if (contatosControllers.length == 1) {
      contatosControllers.keys.first.clear();
    } else {
      contatosControllers.remove(input);
      notifyListeners();
    }
  }

  cpfCnpjListener() {
    String value = cpfCnpjController.text;
    CPF_CNPJ status = CPF_CNPJ.NONE;
    if (value.length == 14) {
      status = CPF_CNPJ.CPF;
    } else if (value.length == 18) {
      status = CPF_CNPJ.CNPJ;
    }
    if (status != cpf_cnpj) {
      cpfCnpjController.value = cpfCnpjMask.updateMask(
          mask: value.length <= 14 ? Masks.cpfMask : Masks.cnpjMask);
      cpf_cnpj = status;
      notifyListeners();
    }
  }

  var loadingCep = false;

  void cepListener() async {
    String cep = cepMask.getUnmaskedText();
    if (cep.length == 8) {
      loadingCep = true;
      notifyListeners();
      Endereco? endereco = await CepService.search(cep);
      if (endereco != null) {
        cidadeController.text = endereco.cidade ?? '';
        logradouroController.text = endereco.logradouro ?? '';
        bairroController.text = endereco.bairro ?? '';
        ufController.text = endereco.uf ?? '';
      }
      loadingCep = false;
      notifyListeners();
    }
  }

  var loading = false;

  saveContato(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      Contato newContato = Contato(
        nome: nomeController.text,
        contatos: contatosControllers.keys.map((e) => e.text).toList(),
        email: getValue(emailController),
        cpf: cpf_cnpj == CPF_CNPJ.CPF ? cpfCnpjController.text : null,
        cnpj: cpf_cnpj == CPF_CNPJ.CNPJ ? cpfCnpjController.text : null,
        empresa: Empresa(
          inscEstadual: cpf_cnpj == CPF_CNPJ.CNPJ
              ? getValue(inscEstadualController)
              : null,
          razaoSozial:
              cpf_cnpj == CPF_CNPJ.CNPJ ? getValue(razaSocialController) : null,
        ),
        endereco: Endereco(
          cep: getValue(cepController),
          cidade: getValue(cidadeController),
          complemento: getValue(complementoController),
          bairro: getValue(bairroController),
          logradouro: getValue(logradouroController),
          numero: getValue(numeroController),
          uf: getValue(ufController),
        ),
      );
      HttpResponse<Contato> response;

      if (contato != null) {
        newContato.id = contato?.id;
        response = await contatoService.updateContato(newContato);
      } else {
        response = await contatoService.addContato(newContato);
      }

      if (response.success) {
        contatoStore.fetchContatos();
      }

      scaffoldMessengerKey.currentState?.showSnackBar(
        CustomSnackBar(message: response.message, isError: !response.success),
      );
      loading = false;
      notifyListeners();
    }
  }

  String? getValue(TextEditingController controller) =>
      controller.text.isEmpty ? null : controller.text;
}

enum CPF_CNPJ { CPF, CNPJ, NONE }

extension ValueExtension on CPF_CNPJ {
  String get value {
    switch (this) {
      case CPF_CNPJ.NONE:
        return 'CPF / CNPJ';
      case CPF_CNPJ.CPF:
        return 'CPF';
      case CPF_CNPJ.CNPJ:
        return 'CNPJ';
      default:
        return 'CPF / CNPJ';
    }
  }
}
