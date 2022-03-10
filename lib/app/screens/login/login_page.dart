import 'package:erp/app/screens/contatos/contatos_page.dart';
import 'package:erp/app/screens/register/register_page.dart';
import 'package:erp/app/shared/utils/http_response.dart';
import 'package:erp/app/shared/components/styled_form_field.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/components/custom_snack_bar.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routeName = '/login';

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
    HttpResponse response = await authService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (response.success) {
      Modular.to.popAndPushNamed(ContatosPage.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(message: response.message, isError: true),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: CustomColors.secondary,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 400,
              ),
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
                                        style: TextStyles.T1
                                            .textColor(CustomColors.white),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () =>
                          Modular.to.popAndPushNamed(RegisterPage.routeName),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Ainda não possui conta?',
                            style: TextStyles.H2,
                          ),
                          Text(
                            'Cadastrar',
                            style:
                                TextStyles.H1.textColor(CustomColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
