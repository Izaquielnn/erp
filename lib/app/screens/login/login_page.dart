import 'package:erp/app/screens/login/styledFormField.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/shared/custom_colors.dart';
import 'package:erp/app/shared/custom_snack_bar.dart';
import 'package:erp/app/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthService authService = Modular.get();

  bool loading = false;

  void login() async {
    setState(() => loading = true);
    bool logged = await authService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (logged) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(message: 'Salvando token e navegando para homepage'),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(message: 'Email ou senha inválidos!', isError: true),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Center(
                child: Text(
                  'ERP',
                  style: TextStyles.T1
                      .textColor(CustomColors.primary)
                      .size(FontSizes.s36),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    StyledFormField(
                      textEditingController: emailController,
                      labelText: 'Email',
                      hintText: 'fulano@email.com',
                      prefixIcon: Icon(Icons.email),
                    ),
                    SizedBox(height: 10),
                    StyledFormField(
                      textEditingController: passwordController,
                      labelText: 'Senha',
                      hintText: '***',
                      obscureText: true,
                      prefixIcon: Icon(Icons.lock),
                    ),
                    SizedBox(height: 40),
                    loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: login,
                            child: Container(
                              decoration: BoxDecoration(
                                color: CustomColors.primary,
                                borderRadius: Corners.s10Border,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: Text(
                                'ENTRAR',
                                style:
                                    TextStyles.T1.textColor(CustomColors.white),
                              )),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
