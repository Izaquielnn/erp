import 'package:erp/app/models/pedido.dart';
import 'package:erp/app/services/pedido_service.dart';
import 'package:flutter/material.dart';

class PedidoStore extends ValueNotifier<PedidoState> {
  final PedidoService pedidoService;
  PedidoStore(this.pedidoService) : super(InitialPedidoState());

  fetchPedidos() async {
    value = LoadingPedidoState();
    List<Pedido>? pedidos = await pedidoService.getPedidos();
    if (pedidos != null) {
      value = SuccessPedidoState(pedidos);
    } else {
      value = ErrorPedidoState();
    }
  }
}

abstract class PedidoState {}

class InitialPedidoState extends PedidoState {}

class LoadingPedidoState extends PedidoState {}

class SuccessPedidoState extends PedidoState {
  final List<Pedido> pedidos;
  SuccessPedidoState(this.pedidos);
}

class ErrorPedidoState extends PedidoState {}
