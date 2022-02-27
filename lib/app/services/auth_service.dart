import 'dart:convert';
import 'package:erp/app/models/user.dart';
import 'package:erp/app/shared/authenticated_http_client.dart';
import 'package:erp/app/shared/config.dart';
import 'package:erp/app/shared/http_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthenticatedHttpClient http;
  AuthService(this.http);

  Future<HttpResponse> login(
      {required String email, required String password}) async {
    try {
      var response = await http.post(
        Uri.parse('${Config.baseUrl}/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        String token = responseBody['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        http.setToken(token);
        return HttpResponse(
          success: true,
          message: 'Login realizado com sucesso!',
        );
      } else {
        return HttpResponse(
          success: false,
          message: 'Email ou senha incorretos!',
        );
      }
    } catch (e) {
      print(e);
      return HttpResponse(
        success: false,
        message: 'Não foi possível realizar login! Tente novamente mais tarde.',
      );
    }
  }

  Future<HttpResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('${Config.baseUrl}/tenant'),
        body: {
          'email': email,
          'password': password,
          'nome': name,
        },
      );

      if (response.statusCode == 409) {
        return HttpResponse(success: false, message: 'Usuário já cadastrado!');
      }

      if (response.statusCode == 201) {
        response = await http.post(
          Uri.parse('${Config.baseUrl}/login'),
          body: {
            'email': email,
            'password': password,
          },
        );

        var responseBody = jsonDecode(response.body);
        String token = responseBody['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        http.setToken(token);
        return HttpResponse(
          success: true,
          message: 'Usuário criado com sucesso!',
        );
      }

      return HttpResponse(
        success: false,
        message:
            'Não foi possível realizar o cadastro! Tente novamente mais tarde.',
      );
    } catch (e) {
      print(e);
      return HttpResponse(
        success: false,
        message:
            'Não foi possível realizar o cadastro! Tente novamente mais tarde.',
      );
    }
  }

  Future<User?> me() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      if (token == null || token.isEmpty) {
        return null;
      } else {
        http.setToken(token);
      }
      var response = await http.get(Uri.parse('${Config.baseUrl}/me'));

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return User.fromMap(responseBody['tenant']);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> logout() async {
    http.setToken('');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
