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

    if (address.startsWith(',')) {
      address = address.substring(1);
    }

    return address.isEmpty ? '' : address;
  }
}
