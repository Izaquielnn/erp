import 'dart:convert';
import 'package:erp/app/models/contato.dart';
import 'package:erp/app/services/authenticated_http_client.dart';
import 'package:erp/app/shared/config.dart';
import 'package:erp/app/shared/http_response.dart';

class ContatoService {
  AuthenticatedHttpClient http;
  ContatoService(this.http);

  Future<List<Contato>?> getContatos() async {
    try {
      var response = await http.get(Uri.parse('${Config.baseUrl}/contato'));

      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        List<Contato> contatos = responseBody['data']
            .map<Contato>((c) => Contato.fromJson(c))
            .toList();
        return contatos;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<HttpResponse<Contato>> addContato(Contato contato) async {
    try {
      var response = await http.post(
        Uri.parse('${Config.baseUrl}/contato'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contato),
      );

      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        Contato contato = Contato.fromJson(responseBody['contato']);
        return HttpResponse(
            success: true,
            message: 'Contato cadastrado com sucesso!',
            value: contato);
      }

      String message =
          'Não foi possível realizar o cadastro! Tente novamente mais tarde.';

      if (response.statusCode == 409) {
        message = 'Contato com cpf ou cnpj já cadastrado!';
      }
      return HttpResponse(success: false, message: message);
    } catch (e) {
      print(e);
      return HttpResponse(
          success: false,
          message:
              'Não foi possível realizar o cadastro! Tente novamente mais tarde.');
    }
  }
}
