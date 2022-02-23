class User {
  String nome;
  String email;
  DadosGerais dadosGerais;

  User({
    required this.email,
    required this.nome,
    required this.dadosGerais,
  });

  User.fromMap(Map map)
      : nome = map['nome'],
        email = map['email'],
        dadosGerais = DadosGerais.fromMap(map['dadosGerais']);
}

class DadosGerais {
  List<String> categoriasContasReceber;
  List<String> categoriasContasPagar;
  List<String> formasPagamento;

  DadosGerais({
    this.categoriasContasPagar = const [],
    this.categoriasContasReceber = const [],
    this.formasPagamento = const [],
  });

  DadosGerais.fromMap(Map map)
      : categoriasContasPagar = List<String>.from(map['categoriasContasPagar']),
        categoriasContasReceber =
            List<String>.from(map['categoriasContasReceber']),
        formasPagamento = List<String>.from(map['formasPagamento']);
}
