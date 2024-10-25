import 'package:banhang/view/dashboard/dashboard_binding.dart';
import 'package:get/get.dart';
import 'package:banhang/route/app_route.dart';
import 'package:banhang/view/dashboard/dashboard_screen.dart';

import '../view/auth/login/LoginSceen.dart';
import '../view/auth/register/RegisterScreen.dart';
import '../view/auth/login/AcceptScreen.dart';
import '../view/auth/login/FogotPasswordScreen.dart';
import '../view/cart/cart_screen.dart';

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
        name: AppRoute.fogotpass,
        page: () => FogotPasswordScreen(),
        children: [
          GetPage(
            name: AppRoute.acceptcode,
            page: () => AcceptCodeScreen(),
          ),
        ]
    ),

    GetPage(
      name: AppRoute.cart,
      page: () => const CartScreen(),
    ),

  ];

}
