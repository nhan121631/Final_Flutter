import 'package:banhang/controller/controllers.dart';
import 'package:banhang/service/remote_service/remote_order_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  // Các biến để quản lý trạng thái
  var isLoading = false.obs;
  var orderMessage = ''.obs;
  final OrderService orderService = OrderService(); // Khởi tạo instance của OrderService

  // Hàm thực hiện checkout
  Future<void> checkOutOrder({
    required int userId,
    required String name,
    required String phone,
    required String address,
    required int payment,
    required String note,
    required double total,
  }) async {
    isLoading.value = true; // Bắt đầu tải
    try {
      // Gọi service để thực hiện checkout
      String message = await orderService.checkOutOrder( // Sử dụng instance orderService
        userId: userId,
        name: name,
        phone: phone,
        address: address,
        payment: payment,
        note: note,
        total: total,
      );
      await cartController.getQuantity(authController.user.value.id);
      orderMessage.value = message; // Cập nhật thông báo
    } catch (e) {
      orderMessage.value = 'Error: ${e.toString()}'; // Xử lý lỗi
    } finally {
      isLoading.value = false; // Kết thúc tải
    }
  }
}
