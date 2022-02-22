import 'dart:convert';
import 'package:erp/app/services/authenticated_http_client.dart';
import 'package:erp/app/shared/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthenticatedHttpClient http;
  AuthService(this.http);

  Future<bool> login({required String email, required String password}) async {
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
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
