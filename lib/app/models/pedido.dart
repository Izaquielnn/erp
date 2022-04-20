import 'dart:convert';

import 'package:erp/app/models/contato.dart';
import 'package:erp/app/models/produto_pedido.dart';

class Pedido {
  String? id;
  Contato cliente;
  List<ProdutoPedido> produtos;
  DateTime previsao_entrega;
  STATUS status;
  MODALIDADE_FRETE modalidade_frete;
  String obs;
  DateTime createdAt;

  Pedido({
    this.id,
    required this.cliente,
    required this.produtos,
    required this.previsao_entrega,
    required this.status,
    required this.createdAt,
    required this.modalidade_frete,
    required this.obs,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'cliente': cliente.id,
      'produtos': produtos.map((p) => p.toMap()).toList(),
      'previsao_entrega': previsao_entrega.toIso8601String(),
      'status': status.value,
      'modalidade_frete': modalidade_frete.value,
      'obs': obs,
    };
  }

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['_id'],
      cliente: Contato.fromJson(map['cliente']),
      createdAt: DateTime.parse(map['createdAt']),
      modalidade_frete: MODALIDADE_FRETE.CIF.from(map['modalidade_frete']),
      obs: map['obs'] ?? '',
      previsao_entrega: DateTime.parse(map['previsao_entrega']),
      status: STATUS.EM_ABERTO.from(map['status']),
      produtos: map['produtos']
          .map<ProdutoPedido>((p) => ProdutoPedido.fromMap(p))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());
}

enum MODALIDADE_FRETE { CIF, FOB }

extension ModalideFreteExtension on MODALIDADE_FRETE {
  String get value {
    switch (this) {
      case MODALIDADE_FRETE.CIF:
        return 'CIF';
      case MODALIDADE_FRETE.FOB:
        return 'FOB';
      default:
        return 'CIF';
    }
  }

  MODALIDADE_FRETE from(String v) {
    switch (v) {
      case 'CIF':
        return MODALIDADE_FRETE.CIF;
      case 'FOB':
        return MODALIDADE_FRETE.FOB;
      default:
        return MODALIDADE_FRETE.CIF;
    }
  }
}

enum STATUS { EM_ABERTO, PREPARADO, ENVIADO, FINALIZADO, CANCELADO }

extension StatusExtension on STATUS {
  String get value {
    switch (this) {
      case STATUS.EM_ABERTO:
        return 'EM ABERTO';
      case STATUS.PREPARADO:
        return 'PREPARADO';
      case STATUS.ENVIADO:
        return 'ENVIADO';
      case STATUS.FINALIZADO:
        return 'FINALIZADO';
      case STATUS.CANCELADO:
        return 'CANCELADO';
      default:
        return 'EM ABERTO';
    }
  }

  STATUS from(String v) {
    switch (v) {
      case 'EM_ABERTO':
        return STATUS.EM_ABERTO;
      case 'PREPARADO':
        return STATUS.PREPARADO;
      case 'ENVIADO':
        return STATUS.ENVIADO;
      case 'FINALIZADO':
        return STATUS.FINALIZADO;
      case 'CANCELADO':
        return STATUS.CANCELADO;
      default:
        return STATUS.EM_ABERTO;
    }
  }
}
