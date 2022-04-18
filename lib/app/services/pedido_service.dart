import 'dart:convert';
import 'package:erp/app/models/pedido.dart';
import 'package:erp/app/shared/utils/authenticated_http_client.dart';
import 'package:erp/app/shared/config.dart';

class PedidoService {
  AuthenticatedHttpClient http;
  PedidoService(this.http);

  Future<List<Pedido>?> getPedidos() async {
    //try {
    var response = await http.get(Uri.parse('${Config.baseUrl}/pedido'));
    print(response);

    if (response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      List<Pedido> pedidos =
          responseBody['data'].map<Pedido>((p) => Pedido.fromMap(p)).toList();

      pedidos.forEach((p) {
        print(p.toJson());
      });
      return pedidos;
    }
    return null;
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
  }
}
