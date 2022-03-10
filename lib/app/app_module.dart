import 'package:erp/app/models/contato.dart';
import 'package:erp/app/screens/contatos/contatos_page.dart';
import 'package:erp/app/screens/contatos/edit_contato/edit_contato_page.dart';
import 'package:erp/app/screens/financas/edit_lancamento/edit_lancamento_page.dart';
import 'package:erp/app/screens/financas/financas_page.dart';
import 'package:erp/app/screens/login/login_page.dart';
import 'package:erp/app/screens/produtos/edit_produto/edit_produto.dart';
import 'package:erp/app/screens/produtos/produtos_page.dart';
import 'package:erp/app/screens/register/register_page.dart';
import 'package:erp/app/screens/splash/splash_page.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/services/financas_service.dart';
import 'package:erp/app/services/produto_service.dart';
import 'package:erp/app/shared/utils/authenticated_http_client.dart';
import 'package:erp/app/services/contato_service.dart';
import 'package:erp/app/stores/contato_store.dart';
import 'package:erp/app/stores/lancamento_store.dart';
import 'package:erp/app/stores/produto_store.dart';
import 'package:erp/app/stores/user_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AuthenticatedHttpClient()),
    Bind((i) => AuthService(i.get())),
    Bind((i) => ContatoService(i.get())),
    Bind((i) => ProdutoService(i.get())),
    Bind((i) => FinancasService(i.get())),
    Bind((i) => ContatoStore(i.get())),
    Bind((i) => ProdutoStore(i.get())),
    Bind((i) => LancamentoStore(i.get())),
    Bind((i) => UserStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => SplashPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      LoginPage.routeName,
      child: (_, args) => LoginPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      RegisterPage.routeName,
      child: (_, args) => RegisterPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      ContatosPage.routeName,
      child: (_, args) => ContatosPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      EditContatoPage.routeName,
      child: (_, args) => EditContatoPage(
        contato: args.data is Contato ? args.data : null,
        nome: args.data is String ? args.data : null,
      ),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      ProdutosPage.routeName,
      child: (_, args) => ProdutosPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      EditProdutoPage.routeName,
      child: (_, args) => EditProdutoPage(
        produto: args.data,
      ),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      FinancasPage.routeName,
      child: (_, args) => FinancasPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      EditLancamentoPage.routeName,
      child: (_, args) => EditLancamentoPage(
        lancamento: args.data,
      ),
      transition: TransitionType.fadeIn,
    ),
  ];
}
