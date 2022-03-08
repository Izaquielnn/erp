import 'package:erp/app/models/contato.dart';

class Lancamento {
  String? id;
  String descricao;
  double valor;
  String conta;
  Contato? cliente;
  DateTime? competencia;
  String? categoria;
  String? formaPagamento;
  DateTime createdAt;

  Lancamento({
    required this.descricao,
    required this.valor,
    required this.conta,
    required this.createdAt,
    this.cliente,
    this.id,
    this.categoria,
    this.competencia,
    this.formaPagamento,
  });

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'valor': valor,
      'cliente': cliente?.id,
      'conta': conta,
      'competencia': competencia?.toIso8601String(),
      'categoria': categoria,
    };
  }

  factory Lancamento.fromMap(Map<String, dynamic> map) {
    return Lancamento(
        id: map['_id'],
        descricao: map['descricao'],
        valor: map['valor']?.toDouble(),
        conta: map['conta'],
        createdAt: DateTime.parse(map['createdAt']),
        categoria: map['categoria'],
        cliente:
            map['cliente'] != null ? Contato.fromJson(map['cliente']) : null,
        competencia: DateTime.parse(map['competencia']),
        formaPagamento: map['formaPagamento']);
  }
}
