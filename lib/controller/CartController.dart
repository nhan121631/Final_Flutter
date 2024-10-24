import 'package:banhang/controller/controllers.dart';
import 'package:get/get.dart';
import 'package:banhang/service/remote_service/remote_cart_service.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  RxInt itemCart = 0.obs; // Thay đổi từ RxInt thành int

  @override
  void onInit() {
    getQuantity(authController.user.value.id);
    super.onInit();
  }

  void addCart(int idProduct, int idUser) async {
    await RemoteCartService().addCart(idProduct, idUser);
    await getQuantity(2); // Gọi lại getQuantity để cập nhật số lượng
  }

  Future<void> getQuantity(int userId) async {
    try {
      int quantity = await RemoteCartService().getQuantity(userId);
      itemCart(quantity);
      print("ok");
      update(); // Gọi update() để làm mới GetBuilder
    } catch (e) {
      print('Error: $e');
    }
  }
}
