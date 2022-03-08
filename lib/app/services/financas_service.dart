import 'dart:convert';
import 'package:erp/app/models/lancamento.dart';
import 'package:erp/app/models/produto.dart';
import 'package:erp/app/shared/authenticated_http_client.dart';
import 'package:erp/app/shared/config.dart';
import 'package:erp/app/shared/http_response.dart';
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

  Future<HttpResponse<Produto>> addProduto(Produto produto) async {
    try {
      var response = await http.post(
        Uri.parse('${Config.baseUrl}/produto'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: produto.toJson(),
      );

      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        Produto produto = Produto.fromMap(responseBody['produto']);
        return HttpResponse(
          success: true,
          message: 'Produto cadastrado com sucesso!',
          value: produto,
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

  Future<HttpResponse<Produto>> updateProduto(Produto produto) async {
    try {
      Response response;
      String body = produto.toJson();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };

      Uri uri = Uri.parse('${Config.baseUrl}/produto/${produto.id}');
      response = await http.put(uri, body: body, headers: headers);

      if (response.statusCode == 202) {
        var responseBody = jsonDecode(response.body);
        Produto produto = Produto.fromMap(responseBody['produto']);
        return HttpResponse(
          success: true,
          message: 'Produto atualizado com sucesso!',
          value: produto,
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
