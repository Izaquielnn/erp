import 'dart:convert';
import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/shared/utils/authenticated_http_client.dart';
import 'package:erp/app/shared/config.dart';
import 'package:erp/app/shared/utils/http_response.dart';
import 'package:http/http.dart';

class FinancasService {
  AuthenticatedHttpClient http;
  FinancasService(this.http);

  Future<List<Lancamento>?> getLancamentos() async {
    try {
      var response = await http.get(Uri.parse('${Config.baseUrl}/lancamento'));

      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        List<Lancamento> lancamentos = responseBody['data']
            .map<Lancamento>((p) => Lancamento.fromMap(p))
            .toList();
        return lancamentos;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<HttpResponse<Lancamento>> addLancamento(Lancamento lancamento) async {
    try {
      var response = await http.post(
        Uri.parse('${Config.baseUrl}/lancamento'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: lancamento.toJson(),
      );

      if (response.statusCode == 201) {
        return HttpResponse(
          success: true,
          message: 'Lançamento cadastrado com sucesso!',
        );
      }

      String message =
          'Não foi possível realizar o cadastro! Tente novamente mais tarde.';
      return HttpResponse(success: false, message: message);
    } catch (e) {
      print(e);
      return HttpResponse(
          success: false,
          message:
              'Não foi possível realizar o cadastro! Tente novamente mais tarde.');
    }
  }

  Future<HttpResponse<Lancamento>> updateLancamento(
    Lancamento lancamento,
  ) async {
    try {
      Response response;
      String body = lancamento.toJson();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };

      Uri uri = Uri.parse('${Config.baseUrl}/lancamento/${lancamento.id}');
      response = await http.put(uri, body: body, headers: headers);

      if (response.statusCode == 202) {
        return HttpResponse(
          success: true,
          message: 'Lançamento atualizado com sucesso!',
        );
      }

      String message =
          'Não foi possível realizar a atualização! Tente novamente mais tarde.';

      return HttpResponse(success: false, message: message);
    } catch (e) {
      print(e);
      return HttpResponse(
          success: false,
          message:
              'Não foi possível realizar a atualização! Tente novamente mais tarde.');
    }
  }
}
