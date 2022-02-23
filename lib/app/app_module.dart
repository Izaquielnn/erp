import 'package:erp/app/screens/login/login_page.dart';
import 'package:erp/app/screens/register/register_page.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/services/authenticated_http_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AuthenticatedHttpClient()),
    Bind((i) => AuthService(i.get()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage()),
    ChildRoute(RegisterPage.routeName, child: (_, args) => RegisterPage()),
  ];
}
