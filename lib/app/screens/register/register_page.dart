import 'package:erp/app/screens/login/login_page.dart';
import 'package:erp/app/shared/http_response.dart';
import 'package:erp/app/shared/styled_form_field.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/shared/custom_colors.dart';
import 'package:erp/app/shared/custom_snack_bar.dart';
import 'package:erp/app/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const String routeName = '/register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  AuthService authService = Modular.get();

  bool loading = false;

  void register() async {
    setState(() => loading = true);
    if (formKey.currentState!.validate()) {
      HttpResponse response = await authService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(message: response.message),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(message: response.message, isError: true),
        );
      }
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
                      textEditingController: nameController,
                      labelText: 'Nome',
                      hintText: 'Pedro Almeida',
                      validator: (name) {
                        if (name == null || name.length < 3) {
                          return 'Nome deve ter no mínimo 3 caracteres';
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.person),
                    ),
                    SizedBox(height: 10),
                    StyledFormField(
                      textEditingController: emailController,
                      labelText: 'Email',
                      hintText: 'fulano@email.com',
                      validator: (email) {
                        if (!RegExp(r'.+\@.+\..+').hasMatch(email ?? '')) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.email),
                    ),
                    SizedBox(height: 10),
                    StyledFormField(
                      textEditingController: passwordController,
                      labelText: 'Senha',
                      hintText: '***',
                      validator: (password) {
                        if (password == null || password.length < 3) {
                          return 'Senha deve ter no mínimo 3 caracteres';
                        }
                        return null;
                      },
                      obscureText: true,
                      prefixIcon: Icon(Icons.lock),
                    ),
                    SizedBox(height: 10),
                    StyledFormField(
                      textEditingController: repeatPasswordController,
                      labelText: 'Repita a senha',
                      hintText: '***',
                      obscureText: true,
                      prefixIcon: Icon(Icons.lock),
                      validator: (password) {
                        if (password != passwordController.text) {
                          return 'Senhas não coincidem';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: register,
                            child: Container(
                              decoration: BoxDecoration(
                                color: CustomColors.primary,
                                borderRadius: Corners.s10Border,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: Text(
                                'CADASTRAR',
                                style:
                                    TextStyles.T1.textColor(CustomColors.white),
                              )),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () => Modular.to.popAndPushNamed(LoginPage.routeName),
                child: Column(
                  children: [
                    Text(
                      'já é cadastrado?',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomColors.primary,
                        fontWeight: FontWeight.bold,
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
