import 'dart:convert';
import 'package:erp/app/models/endereco.dart';
import 'package:http/http.dart' as http;

class CepService {
  static Future<Endereco?> search(String cep) async {
    Endereco? endereco;
    try {
      var response =
          await http.get(Uri.parse('https://brasilapi.com.br/api/cep/v1/$cep'));

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        endereco = Endereco(
          cep: body['cep'],
          cidade: body['city'],
          uf: body['state'],
          bairro: body['neighborhood'],
          logradouro: body['street'],
        );
      }
    } catch (e) {
      print(e);
    }
    return endereco;
  }
}
