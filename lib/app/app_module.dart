import 'package:erp/app/screens/contatos/contatos_page.dart';
import 'package:erp/app/screens/edit_contato/edit_contato_page.dart';
import 'package:erp/app/screens/home/home_page.dart';
import 'package:erp/app/screens/login/login_page.dart';
import 'package:erp/app/screens/register/register_page.dart';
import 'package:erp/app/screens/splash/splash_page.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/shared/authenticated_http_client.dart';
import 'package:erp/app/services/contato_service.dart';
import 'package:erp/app/stores/contato_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AuthenticatedHttpClient()),
    Bind((i) => AuthService(i.get())),
    Bind((i) => ContatoService(i.get())),
    Bind((i) => ContatoStore(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SplashPage()),
    ChildRoute(HomePage.routeName, child: (_, args) => HomePage()),
    ChildRoute(LoginPage.routeName, child: (_, args) => LoginPage()),
    ChildRoute(RegisterPage.routeName, child: (_, args) => RegisterPage()),
    ChildRoute(ContatosPage.routeName, child: (_, args) => ContatosPage()),
    ChildRoute(EditContatoPage.routeName,
        child: (_, args) => EditContatoPage(contato: args.data)),
  ];
}
