import 'package:get/get.dart';

import '../view/auth/login/login_screen.dart';
import '../view/auth/login/fogot_password_screen.dart';
import '../view/auth/register/register_screen.dart';
import '../view/dashboard/dashboard_binding.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../view/auth/login/accept_code_screen.dart';
import 'app_route.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
      binding: DashboardBinding()
    ),

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
      page: () => const FogotPasswordScreen(),
      children: [
        GetPage(
          name: AppRoute.acceptcode,
          page: () => const AcceptCodeScreen(),
        ),
      ]
    ),
  ];
}