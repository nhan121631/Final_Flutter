import 'package:banhang/controller/controllers.dart';
import 'package:banhang/service/remote_service/remote_order_service.dart';
import 'package:get/get.dart';

import '../model/order_model.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  // Các biến để quản lý trạng thái
  var isLoading = false.obs;
  var orderMessage = ''.obs;
  var orders = <Order>[].obs;
  void onInit() {
    super.onInit();
    fetchOrders(authController.user.value.id);
  }

  final OrderService orderService = OrderService(); // Khởi tạo instance của OrderService

  // Hàm lấy danh sách đơn hàng của người dùng
  Future<void> fetchOrders(int userId) async {
    try {
      isLoading.value = true; // Bắt đầu tải dữ liệu
      orderMessage.value = ''; // Reset message trước khi tải dữ liệu

      List<Order> fetchedOrders = await orderService.getOrders(userId);
      orders.assignAll(fetchedOrders); // Cập nhật danh sách đơn hàng
      print("order size: ${orders.length}");
    } catch (e) {
      orderMessage.value = 'Không thể tải đơn hàng: $e';
    } finally {
      isLoading.value = false; // Dừng tải sau khi hoàn tất
    }
  }
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
      await homeController.getproductRecomend();
      await categoryController.fetchCategories();
      orderMessage.value = message; // Cập nhật thông báo
    } catch (e) {
      orderMessage.value = 'Error: ${e.toString()}'; // Xử lý lỗi
    } finally {
      isLoading.value = false; // Kết thúc tải
    }
  }
}
