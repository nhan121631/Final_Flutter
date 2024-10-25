import 'package:banhang/controller/cart_controller.dart';
import 'package:banhang/controller/auth_controller.dart';
import 'package:banhang/controller/category_controller.dart';
import 'package:banhang/controller/dashboard_controller.dart';
import 'package:banhang/controller/home_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(CartController());
    Get.put(CategoryController());
    Get.put(AuthController());

  }
}
