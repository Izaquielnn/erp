import 'package:erp/app/models/empresa.dart';
import 'package:erp/app/models/endereco.dart';

class Contato {
  String? id;
  String nome;
  String? email;
  String? cnpj;
  String? cpf;
  Empresa empresa;

  Endereco endereco;
  List<String> contatos;
  String? avatar;

  Contato({
    this.id,
    required this.nome,
    this.email,
    this.cnpj,
    this.cpf,
    Empresa? empresa,
    Endereco? endereco,
    this.contatos = const [],
    this.avatar,
  })  : empresa = empresa ?? Empresa(),
        endereco = endereco ?? Endereco();

  Contato.fromJson(Map map)
      : id = map['_id'],
        nome = map['nome'],
        email = map['email'],
        cnpj = map['cnpj'],
        cpf = map['cpf'],
        empresa = Empresa.fromJson(map['empresa']),
        endereco = Endereco.fromJson(map['endereco']),
        contatos = List<String>.from(map['contatos']),
        avatar = map['avatar'];

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'email': email,
        'cpf': cpf,
        'cnpj': cnpj,
        'empresa': empresa.toJson(),
        'endereco': endereco.toJson(),
        'contatos': contatos,
        'email': email,
      };
}
