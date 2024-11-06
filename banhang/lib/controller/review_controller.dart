import 'package:banhang/service/remote_service/remote_review_service.dart';
import 'package:get/get.dart';

import 'controllers.dart';


class Reviewcontroller extends GetxController {
  static Reviewcontroller instance = Get.find();
  var isLoading = false.obs;
  var reviewMessage = ''.obs;
  // Hàm thực hiện checkout
  Future<void> addReview({
    required int userId,
    required int productId,
    required String comment,
    required int star}) async {
    isLoading.value = true;
    try {
      // Gọi service để thực hiện checkout
      String message = await ReviewService().addReview(userId: userId, productId: productId, star: star, comment: comment);
      homeController.getproductPupular();
      categoryController.fetchCategories();
      reviewMessage.value = message; // Cập nhật thông báo
    } catch (e) {
      reviewMessage.value = 'Error: ${e.toString()}'; // Xử lý lỗi
    } finally {
      isLoading.value = false; // Kết thúc tải
    }
  }
}
