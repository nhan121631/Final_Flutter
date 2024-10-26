import 'package:banhang/controller/controllers.dart';
import 'package:banhang/model/cart_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:banhang/service/remote_service/remote_cart_service.dart';

import '../route/app_route.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  // RxInt itemCart = 0.obs;
  ValueNotifier<int> itemCart = ValueNotifier<int>(0);
  RxList<CartItem> cartitems = List<CartItem>.empty(growable: true).obs;

  @override
  void onInit() {
    getQuantity(authController.user.value.id);
    super.onInit();
  }

  void addCart(int idProduct, int idUser) async {
    await RemoteCartService().addCart(idProduct, idUser);
    await getQuantity(authController.user.value.id); // Gọi lại getQuantity để cập nhật số lượng
  }

  Future<void> getQuantity(int userId) async {
    try {
      int quantity = await RemoteCartService().getQuantity(userId);
      itemCart.value = quantity;

      print("item: ${itemCart.value}");
      update(); // Gọi update() để làm mới GetBuilder
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getCartItem(int userId) async{
    try {
      var results = await RemoteCartService().getCartItem(userId);
      if(results!=null){
        cartitems.assignAll(results);
      }
    }catch (e) {
         print('Lỗi khi lấy cart: $e'); // Bắt lỗi nếu có
    } finally {
        print('Số lượng cart items: ${cartitems.length}'); // In ra số lượng sản phẩm
    }
  }
  Future<void> loadCart() async{
    await cartController.getCartItem(authController.user.value.id);
    Get.toNamed(AppRoute.cart);
  }
  Future<void> updateQuantityItem(int id, int state) async {
    try {
      await RemoteCartService().updateCartItem(id, state);
    //  await getCartItem(authController.user.value.id);
      print('Item đã được cập nhật');
      // Thêm logic cập nhật lại giỏ hàng nếu cần
    } catch (e) {
      print('Lỗi khi cập nhật: $e');
    }
  }
  Future<void> deleteCartItem(int id) async {
    try {
      await RemoteCartService().deleteCartItem(id);
    //  await getCartItem(authController.user.value.id);
      print('Item đã được xóa');
      // Thêm logic cập nhật lại giỏ hàng nếu cần
    } catch (e) {
      print('Lỗi khi xóa item trong controller: $e');
    }
  }
  var total = 0.0.obs; // Để lưu tổng giá trị

  void updateTotal() {
    total.value = cartitems.fold(0, (sum, item) {
      return sum + item.product.sellPrice * item.quantity;
    });
  }
}
