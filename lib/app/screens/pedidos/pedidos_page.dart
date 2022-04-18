import 'package:erp/app/services/pedido_service.dart';
import 'package:erp/app/shared/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({Key? key}) : super(key: key);

  static const String routeName = '/pedidos';

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  PedidoService pedidoService = Modular.get();

  @override
  void initState() {
    super.initState();
    pedidoService.getPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Menu(page: Pages.PEDIDOS),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }
}
