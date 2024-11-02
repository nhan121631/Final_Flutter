import 'package:banhang/controller/auth_controller.dart';
import 'package:banhang/controller/category_controller.dart';
import 'package:banhang/controller/dashboard_controller.dart';
import 'package:banhang/controller/home_controller.dart';
import 'package:banhang/controller/order_controller.dart';
import 'package:banhang/controller/review_controller.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(CartController());
    Get.put(CategoryController());
    Get.put(AuthController());
    Get.put(OrderController());
    Get.put(Reviewcontroller());


  }
}
