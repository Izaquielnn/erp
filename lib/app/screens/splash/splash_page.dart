import 'package:erp/app/screens/financas/financas_page.dart';
import 'package:erp/app/screens/login/login_page.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthService authService = Modular.get();
  UserStore userStore = Modular.get();

  @override
  void initState() {
    authService.me().then((user) {
      if (user != null) {
        userStore.setUser(user);
        Modular.to.popAndPushNamed(FinancasPage.routeName);
      } else {
        Modular.to.popAndPushNamed(LoginPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.secondary,
      child: Center(
        child: CircularProgressIndicator(
          color: CustomColors.primary,
        ),
      ),
    );
  }
}
