import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/services/financas_service.dart';
import 'package:flutter/material.dart';

class LancamentoStore extends ValueNotifier<LancamentoState> {
  final FinancasService financasService;
  LancamentoStore(this.financasService) : super(InitialLancamentoState());

  fetchLancamentos() async {
    value = LoadingLancamentoState();
    List<Lancamento>? lancamentos = await financasService.getLancamentos();

    if (lancamentos != null) {
      double saldo = 0;
      double entradas = 0;
      double saidas = 0;
      lancamentos.forEach((l) {
        if (l.valor > 0) {
          entradas += l.valor;
        }
        if (l.valor < 0) {
          saidas += l.valor;
        }
        saldo += l.valor;
      });

      value = SuccessLancamentoState(lancamentos, saldo, entradas, saidas);
    } else {
      value = ErrorLancamentoState();
    }
  }
}

abstract class LancamentoState {}

class InitialLancamentoState extends LancamentoState {}

class LoadingLancamentoState extends LancamentoState {}

class SuccessLancamentoState extends LancamentoState {
  final List<Lancamento> lancamentos;
  final double saldo;
  final double entradas;
  final double saidas;
  SuccessLancamentoState(
      this.lancamentos, this.saldo, this.entradas, this.saidas);
}

class ErrorLancamentoState extends LancamentoState {}
