import 'package:banhang/view/dashboard/dashboard_binding.dart';
import 'package:banhang/view/order/formorder/form.dart';
import 'package:get/get.dart';
import 'package:banhang/route/app_route.dart';
import 'package:banhang/view/dashboard/dashboard_screen.dart';

import '../view/auth/login/LoginSceen.dart';
import '../view/auth/register/RegisterScreen.dart';
import '../view/auth/login/AcceptScreen.dart';
import '../view/auth/login/FogotPasswordScreen.dart';
import '../view/cart/cart_screen.dart';
import '../view/product_details/productdetails_screen.dart';

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
      transition: Transition.native,
    ),

    GetPage(
      name: AppRoute.orderform,
      page: () => OrderForm(total: Get.arguments?['totalAmount']),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: AppRoute.details,
      page: () => ProductDetailsScreen(product: Get.arguments?['product']),
      transition: Transition.fadeIn,
    ),

  ];

}
