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
      double saldo = lancamentos.fold<double>(
          0, (previousValue, lancamento) => previousValue += lancamento.valor);
      value = SuccessLancamentoState(lancamentos, saldo);
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
  SuccessLancamentoState(this.lancamentos, this.saldo);
}

class ErrorLancamentoState extends LancamentoState {}
