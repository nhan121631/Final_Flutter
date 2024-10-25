import 'package:banhang/view/cart/cart_screen.dart';
import 'package:banhang/view/dashboard/dashboard_binding.dart';
import 'package:get/get.dart';
import 'package:banhang/route/app_route.dart';
import 'package:banhang/view/dashboard/dashboard_screen.dart';

import '../view/auth/login/accept_code_screen.dart';
import '../view/auth/login/fogot_password_screen.dart';
import '../view/auth/login/login_sceen.dart';
import '../view/auth/register/register_screen.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding()),

    GetPage(
      name: AppRoute.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoute.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoute.forgotpass,
      page: () => const ForgotPasswordScreen(),
      children: [
        GetPage(
          name: AppRoute.acceptcode,
          page: () => const AcceptCodeScreen(),
        ),
      ],
    ),

    GetPage(
      name: AppRoute.cart,
      page: () => const CartScreen(),
    ),
  ];

}
