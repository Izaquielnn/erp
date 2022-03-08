import 'package:erp/app/screens/contatos/contatos_page.dart';
import 'package:erp/app/screens/home/home_page.dart';
import 'package:erp/app/screens/login/login_page.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthService authService = Modular.get();

  @override
  void initState() {
    authService.me().then((user) {
      if (user != null) {
        Modular.to.popAndPushNamed(HomePage.routeName);
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
