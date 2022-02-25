class Contato {
  String nome;
  String? email;
  String? cnpj;
  String? cpf;
  Empresa empresa;

  Endereco endereco;
  List<String> contatos;
  String? avatar;

  Contato({
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
      : nome = map['nome'],
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

class Empresa {
  String? razaoSozial;
  String? inscEstadual;

  Empresa({this.razaoSozial, this.inscEstadual});

  Empresa.fromJson(Map map)
      : razaoSozial = map['razaoSozial'],
        inscEstadual = map['inscEstadual'];

  Map<String, dynamic> toJson() => {
        'razaoSozial': razaoSozial,
        'inscEstadual': inscEstadual,
      };
}

class Endereco {
  String? cep;
  String? cidade;
  String? logradouro;
  String? numero;
  String? uf;
  String? bairro;
  String? complemento;

  Endereco({
    this.cep,
    this.cidade,
    this.complemento,
    this.bairro,
    this.logradouro,
    this.numero,
    this.uf,
  });

  Endereco.fromJson(Map map)
      : cep = map['cep'],
        bairro = map['bairro'],
        cidade = map['cidade'],
        logradouro = map['logradouro'],
        numero = map['numero'],
        uf = map['uf'],
        complemento = map['complemento'];

  Map<String, dynamic> toJson() => {
        'cep': cep,
        'bairro': bairro,
        'cidade': cidade,
        'logradouro': logradouro,
        'numero': numero,
        'uf': uf,
        'complemento': complemento,
      };

  @override
  String toString() {
    String address = logradouro ?? '';
    address = numero != null ? '$address, $numero' : address;
    address = bairro != null ? '$address - $bairro' : address;
    address = cidade != null ? '$address, $cidade' : address;
    address = uf != null ? '$address - $uf' : address;
    address = cep != null ? '$address, $cep' : address;
    address = complemento != null ? '$address, $complemento' : address;

    return address.isEmpty ? '-' : address;
  }
}
