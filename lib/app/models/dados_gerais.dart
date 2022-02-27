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
