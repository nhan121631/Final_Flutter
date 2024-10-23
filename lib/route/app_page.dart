import 'package:banhang/view/dashboard/dashboard_binding.dart';
import 'package:get/get.dart';
import 'package:banhang/route/app_route.dart';
import 'package:banhang/view/dashboard/dashboard_screen.dart';

import '../view/auth/login/LoginSceen.dart';
import '../view/auth/register/RegisterScreen.dart';

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

  ];

}
