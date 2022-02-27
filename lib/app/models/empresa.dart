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
