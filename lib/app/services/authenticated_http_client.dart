import 'package:http/http.dart' as http;

class AuthenticatedHttpClient extends http.BaseClient {
  String token = '';

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (token.isNotEmpty) {
      request.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }
    return request.send();
  }

  setToken(String token) {
    this.token = token;
  }
}
