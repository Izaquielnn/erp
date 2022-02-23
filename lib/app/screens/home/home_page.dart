import 'package:erp/app/screens/login/login_page.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/shared/custom_colors.dart';
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
      ),
    );
  }
}
