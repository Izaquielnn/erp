import 'package:erp/app/models/user.dart';
import 'package:erp/app/screens/contatos/contatos_page.dart';
import 'package:erp/app/screens/financas/financas_page.dart';
import 'package:erp/app/screens/login/login_page.dart';
import 'package:erp/app/screens/produtos/produtos_page.dart';
import 'package:erp/app/services/auth_service.dart';
import 'package:erp/app/shared/components/custom_button.dart';
import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styled_icons.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:erp/app/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum Pages { CONTATOS, PRODUTOS, FINANCAS }

class Menu extends StatelessWidget {
  Menu({Key? key, required this.page}) : super(key: key);

  UserStore userStore = Modular.get();
  AuthService authService = Modular.get();
  Pages page;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
        elevation: 0,
        backgroundColor: CustomColors.primary,
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'ERP',
                style: TextStyles.T1
                    .textColor(CustomColors.white)
                    .size(FontSizes.s36),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    buildMenuItem(
                        selected: page == Pages.CONTATOS,
                        title: 'Contatos',
                        icon: StyledIcons.user,
                        onSelect: () {
                          Modular.to.popAndPushNamed(ContatosPage.routeName);
                        }),
                    buildMenuItem(
                        selected: page == Pages.PRODUTOS,
                        title: 'Produtos',
                        icon: StyledIcons.product,
                        onSelect: () {
                          Modular.to.popAndPushNamed(ProdutosPage.routeName);
                        }),
                    buildMenuItem(
                        selected: page == Pages.FINANCAS,
                        title: 'Finanças',
                        icon: StyledIcons.money,
                        onSelect: () {
                          Modular.to.popAndPushNamed(FinancasPage.routeName);
                        }),
                  ],
                ),
              ),
              ValueListenableBuilder<User?>(
                valueListenable: userStore,
                builder: (context, user, child) => Column(
                  children: [
                    Text(
                      user?.nome ?? '',
                      style: TextStyles.T1.textColor(CustomColors.secondary),
                    ),
                    Text(
                      user?.email ?? '',
                      style: TextStyles.Body2.textColor(CustomColors.secondary),
                    ),
                    SizedBox(height: 20),
                    CustomButton.secondary(
                      text: 'SAIR',
                      onTap: () {
                        authService.logout();
                        userStore.setUser(null);
                        Modular.to.popAndPushNamed(LoginPage.routeName);
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                      icon: Icon(
                        Icons.exit_to_app,
                        color: CustomColors.primaryVariant,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  buildMenuItem({
    bool selected = false,
    required String title,
    required ImageProvider<Object> icon,
    required VoidCallback onSelect,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8, top: 30),
      child: GestureDetector(
        onTap: onSelect,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageIcon(
                  icon,
                  size: 18,
                  color: CustomColors.white.withOpacity(selected ? 1 : .7),
                ),
                SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyles.T1
                      .textColor(
                          CustomColors.white.withOpacity(selected ? 1 : .7))
                      .size(selected ? 18 : 14),
                ),
              ],
            ),
            if (selected)
              Container(
                width: 5,
                height: 10,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: Corners.s10Border,
                  color: CustomColors.white,
                ),
              )
          ],
        ),
      ),
    );
  }
}
