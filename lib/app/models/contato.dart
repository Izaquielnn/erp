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

  Contato.fromMap(Map map)
      : nome = map['nome'],
        email = map['email'],
        cnpj = map['cnpj'],
        cpf = map['cpf'],
        empresa = Empresa.fromMap(map['empresa']),
        endereco = Endereco.fromMap(map['endereco']),
        contatos = List<String>.from(map['contatos']),
        avatar = map['avatar'];
}

class Empresa {
  String? razaoSozial;
  String? inscEstadual;

  Empresa({this.razaoSozial, this.inscEstadual});

  Empresa.fromMap(Map map)
      : razaoSozial = map['razaoSozial'],
        inscEstadual = map['inscEstadual'];
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

  Endereco.fromMap(Map map)
      : cep = map['cep'],
        bairro = map['bairro'],
        cidade = map['cidade'],
        logradouro = map['logradouro'],
        numero = map['numero'],
        uf = map['uf'],
        complemento = map['complemento'];

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
