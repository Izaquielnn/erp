import 'dart:convert';

import 'package:erp/app/models/produto.dart';

class ProdutoPedido {
  String? id;
  Produto produto;
  int quantidade;
  double valor;

  ProdutoPedido({
    this.id,
    required this.produto,
    required this.quantidade,
    required this.valor,
  });

  Map<String, dynamic> toMap() {
    return {
      'produto': produto.id ?? '',
      'quantidade': quantidade,
      'valor': valor,
      if (id != null) '_id': id
    };
  }

  factory ProdutoPedido.fromMap(Map<String, dynamic> map) {
    return ProdutoPedido(
      id: map['_id'],
      valor: map['valor']?.toDouble(),
      quantidade: map['quantidade'],
      produto: Produto.fromMap(map['produto']),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '${produto.descricao} (${produto.unidade}) x $quantidade';
  }
}
