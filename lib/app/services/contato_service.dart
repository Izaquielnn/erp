import 'dart:convert';
import 'package:erp/app/models/contato.dart';
import 'package:erp/app/services/authenticated_http_client.dart';
import 'package:erp/app/shared/config.dart';

class ContatoService {
  AuthenticatedHttpClient http;
  ContatoService(this.http);

  Future<List<Contato>?> getContatos() async {
    try {
      var response = await http.get(Uri.parse('${Config.baseUrl}/contato'));

      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        List<Contato> contatos = responseBody['data']
            .map<Contato>((c) => Contato.fromMap(c))
            .toList();
        return contatos;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
