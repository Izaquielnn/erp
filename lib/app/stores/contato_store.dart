import 'package:erp/app/models/contato.dart';
import 'package:erp/app/services/contato_service.dart';
import 'package:flutter/material.dart';

class ContatoStore extends ValueNotifier<ContatoState> {
  final ContatoService contatoService;
  ContatoStore(this.contatoService) : super(InitialContatoState());

  fetchContatos() async {
    value = LoadingContatoState();
    List<Contato>? contatos = await contatoService.getContatos();
    if (contatos != null) {
      value = SuccessContatoState(contatos);
    } else {
      value = ErrorContatoState();
    }
  }
}

abstract class ContatoState {}

class InitialContatoState extends ContatoState {}

class LoadingContatoState extends ContatoState {}

class SuccessContatoState extends ContatoState {
  final List<Contato> contatos;
  SuccessContatoState(this.contatos);
}

class ErrorContatoState extends ContatoState {}
