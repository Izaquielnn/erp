import 'package:erp/app/models/dados_gerais.dart';

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
