import 'dart:convert';

class Produto {
  String? id;
  String descricao;
  double? preco;
  String? codigoSKU;
  String? tipo;
  String? unidade;
  String? grupoTributario;
  String? CFOP;
  String? NCM;
  String? origem;

  Produto({
    required this.descricao,
    this.CFOP,
    this.id,
    this.NCM,
    this.codigoSKU,
    this.grupoTributario,
    this.origem,
    this.preco,
    this.tipo,
    this.unidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'preco': preco,
      'codigoSKU': codigoSKU,
      'tipo': tipo,
      'unidade': unidade,
      'grupoTributario': grupoTributario,
      'CFOP': CFOP,
      'NCM': NCM,
      'origem': origem,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['_id'],
      descricao: map['descricao'] ?? '',
      preco: map['preco']?.toDouble(),
      codigoSKU: map['codigoSKU'],
      tipo: map['tipo'],
      unidade: map['unidade'],
      grupoTributario: map['grupoTributario'],
      CFOP: map['CFOP'],
      NCM: map['NCM'],
      origem: map['origem'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) =>
      Produto.fromMap(json.decode(source));
}
