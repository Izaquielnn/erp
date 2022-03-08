import 'package:erp/app/screens/contatos/contatos_page.dart';
import 'package:erp/app/screens/financas/financas_page.dart';
import 'package:erp/app/screens/login/login_page.dart';
import 'package:erp/app/screens/produtos/produtos_page.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = Modular.get();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: CustomColors.secondary,
        appBar: AppBar(
          title: Text('Homepage'),
          leading: Container(),
          actions: [
            IconButton(
                onPressed: () {
                  authService.logout();
                  Modular.to.popAndPushNamed(LoginPage.routeName);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                Modular.to.pushNamed(ContatosPage.routeName);
              },
              child: Text('Contatos'),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Modular.to.pushNamed(ProdutosPage.routeName);
              },
              child: Text('Produtos'),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Modular.to.pushNamed(FinancasPage.routeName);
              },
              child: Text('Finanças'),
            ),
          ],
        ),
      ),
    );
  }
}
