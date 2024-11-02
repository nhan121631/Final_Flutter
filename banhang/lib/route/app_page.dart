import 'package:banhang/view/cart/cart_screen.dart';
import 'package:banhang/view/dashboard/dashboard_binding.dart';
import 'package:banhang/view/profile/components/info_screen.dart';
import 'package:banhang/view/profile/profile_screen.dart';
import 'package:banhang/view/profile/update_profile_screen.dart';
import 'package:get/get.dart';
import 'package:banhang/route/app_route.dart';
import 'package:banhang/view/dashboard/dashboard_screen.dart';

import '../view/auth/login/accept_screen.dart';
import '../view/auth/login/fogot_password_screen.dart';
import '../view/auth/login/login_sceen.dart';
import '../view/auth/register/register_screen.dart';
import '../view/order/formorder/form.dart';
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
      name: AppRoute.forgotpass,
      page: () => ForgotPasswordScreen(),
      children: [
        GetPage(
          name: AppRoute.acceptcode,
          page: () => AcceptCodeScreen(),
        ),
      ],
    ),

    GetPage(
      name: AppRoute.cart,
      page: () => const CartScreen(),
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


    GetPage(
      name: AppRoute.updateprofile,
      page: () => UpdateProfileScreen(),
    ),

    GetPage(
      name: AppRoute.infoapp,
      page: () => InfoScreen(),
    ),
  ];

}
